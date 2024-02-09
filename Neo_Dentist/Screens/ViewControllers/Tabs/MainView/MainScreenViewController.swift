//
//  MainViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit
import Combine
import PanModal

protocol MainScreenViewControllerFactory {
    func makeClinicServicesListViewController() -> ClinicServicesListViewController 
    func makeClinicServiceViewController(serviceID: Int) -> ClinicServiceViewController
    func makeDoctorsListViewController() -> DoctorsListViewController
    func makeDoctorViewController(doctorID: Int) -> DoctorViewController
    func makeAppointmentViewController(appointmentRequest: MakeAppointmentRequest?) -> AppointmentDetailsViewController
    func makeSelectDateViewController() -> SelectDateViewController
}

class MainScreenViewController: BaseViewController {
    //MARK: Properties
    private let viewModel: MainScreenViewModel
    private let viewControllersFactory: MainScreenViewControllerFactory
    
    private var subscriptions = Set<AnyCancellable>()
    private var mainScreenRootView: MainScreenRootView {
        return view as! MainScreenRootView
    }
    
    //MARK: Methods
    init(viewModel: MainScreenViewModel,
         viewControllersFactory: MainScreenViewControllerFactory){
        self.viewControllersFactory = viewControllersFactory
        self.viewModel = viewModel
        super.init()
        //bindNavigations()
    }
    
    override func loadView() {
        super.loadView()
        view = MainScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        navigationController?.delegate = self
        viewModel.getServices()
        viewModel.getAdvertisement()
        viewModel.getRecomendedDoctors()
        observeNavigationAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainScreenRootView.setUserName(text: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName))
    }
}

//MARK: Navigation
private extension MainScreenViewController {
    func observeNavigationAction() {
        let publisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: publisher)
    }
    
    func subscribe(to publisher: AnyPublisher<MainScreenNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink {[weak self] action in
                guard let self else { return }
                self.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to action: MainScreenNavigationAction) {
        switch action {
        case .present(let view):
           present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: MainScreenViewState) {
        switch view {
        case .initial:
            viewModel.setInitialState()
        case .clinicServicesListView:
            self.presentClinicServicesListViewController()
        case .clinicServiceView:
            self.presentClinicServiceViewController()
        case .doctorsListView:
            self.presentDoctorsListViewController()
        case .doctorView:
            self.presentDoctorViewController()
        case .selectDateView:
            self.presentSelectDateViewController()
        case .appointmentDetailsView:
            self.presentAppointmentDetailsViewController()
        }
    }
    
    func presentClinicServicesListViewController() {
        let clinicServicesListViewController = viewControllersFactory.makeClinicServicesListViewController()
        navigationController?.pushViewController(clinicServicesListViewController, animated: true)
    }
    
    func presentClinicServiceViewController() {
        guard let serviceID = viewModel.serviceID else { return }
        let clinicServiceViewController = viewControllersFactory.makeClinicServiceViewController(serviceID: serviceID)
        navigationController?.presentPanModal(clinicServiceViewController)
    }
    
    func presentDoctorsListViewController() {
        let doctorsListViewController = viewControllersFactory.makeDoctorsListViewController()
        navigationController?.pushViewController(doctorsListViewController, animated: true)
    }
    
    func presentDoctorViewController() {
        guard let doctorID = viewModel.doctorID else { return }
        let doctorViewController = viewControllersFactory.makeDoctorViewController(doctorID: doctorID)
        navigationController?.pushViewController(doctorViewController, animated: true)
    }
    
    func presentSelectDateViewController() {
        let selectDateViewController = viewControllersFactory.makeSelectDateViewController()
        navigationController?.pushViewController(selectDateViewController, animated: true)
    }
    
    func presentAppointmentDetailsViewController() {
        guard let appointmentRequest = viewModel.appointmentRequest else { return }
        let appointmentDetailsViewController = viewControllersFactory.makeAppointmentViewController(appointmentRequest: appointmentRequest)
        navigationController?.pushViewController(appointmentDetailsViewController, animated: true)
    }
}

//MARK: Navigation Controller
extension MainScreenViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        hideAndShowNavigationBar(for: viewController, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
    }
    
    func hideAndShowNavigationBar(for viewController: UIViewController, animated: Bool) {
        if viewController is MainScreenViewController {
            hideNavigationBar(animated: animated)
            tabBarController?.tabBar.isHidden = false
        } else {
            showNavigationBar(animated: animated)
            tabBarController?.tabBar.isHidden = true
        }
    }

    func findMainScreenViewState(for viewController: UIViewController) -> MainScreenViewState? {
        switch viewController {
        case is ClinicServicesListViewController:
            return .clinicServicesListView
        case is ClinicServiceViewController:
            return .clinicServiceView
        case is DoctorsListViewController:
            return .doctorsListView
        case is DoctorViewController:
            return .doctorView
        case is SelectDateViewController:
            return .selectDateView
        case is AppointmentDetailsViewController:
            return .appointmentDetailsView
        default:
            assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
            return nil
        }
    }
}

