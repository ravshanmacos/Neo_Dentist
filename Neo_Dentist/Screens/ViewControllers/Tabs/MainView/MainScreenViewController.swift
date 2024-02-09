//
//  MainViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit
import Combine
import PanModal

class MainScreenViewController: BaseViewController {
    //MARK: Properties
    private let viewModel: MainScreenViewModel
    
    //Child ViewControllers
    private let clinicServicesListViewControllerFactory: () -> ClinicServicesListViewController
    private let clinicServiceViewControllerFactory: (Int) -> ClinicServiceViewController
    private let doctorsListViewControllerFactory: () -> DoctorsListViewController
    private let doctorViewControllerFactory: (Int) -> DoctorViewController
    private let selectDateViewControllerFactory: () -> SelectDateViewController
    private let appointmentDetailsControllerFactory: () -> AppointmentDetailsViewController
    
    private var mainScreenRootView: MainScreenRootView {
        return view as! MainScreenRootView
    }
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModel: MainScreenViewModel,
         clinicServicesListViewControllerFactory: @escaping () -> ClinicServicesListViewController,
         clinicServiceViewControllerFactory: @escaping (Int) -> ClinicServiceViewController,
         doctorsListViewControllerFactory: @escaping () -> DoctorsListViewController,
         doctorViewControllerFactory: @escaping (Int) -> DoctorViewController,
         selectDateViewControllerFactory: @escaping () -> SelectDateViewController,
         appointmentDetailsControllerFactory: @escaping () -> AppointmentDetailsViewController
    ){
        self.clinicServicesListViewControllerFactory = clinicServicesListViewControllerFactory
        self.clinicServiceViewControllerFactory = clinicServiceViewControllerFactory
        self.doctorsListViewControllerFactory = doctorsListViewControllerFactory
        self.doctorViewControllerFactory = doctorViewControllerFactory
        self.selectDateViewControllerFactory = selectDateViewControllerFactory
        self.appointmentDetailsControllerFactory = appointmentDetailsControllerFactory
        self.viewModel = viewModel
        super.init()
        navigationController?.delegate = self
        //bindNavigations()
    }
    
    override func loadView() {
        super.loadView()
        view = MainScreenRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        observeNavigationAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
        
        mainScreenRootView.setUserName(text: UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName))
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


extension MainScreenViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
}

//MARK: Navigation
private extension MainScreenViewController {
    func observeNavigationAction() {
        let publisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: publisher)
    }
    
    func subscribe(to publisher: AnyPublisher<MainScreenNavigationAction?, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink {[weak self] action in
                guard let self else { return }
                self.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to action: MainScreenNavigationAction?) {
        switch action {
        case .present(let view):
           present(view: view)
        case .presented, .none:
            break
        }
    }
    
    func present(view: MainScreenViewState) {
        switch view {
        case .clinicServicesListView:
            self.presentClinicServicesListViewController()
        case .clinicServiceView(let serviceID):
            self.presentClinicServiceViewController(serviceID: serviceID)
        case .doctorsListView:
            self.presentDoctorsListViewController()
        case .doctorView(let doctorID):
            self.presentDoctorViewController(doctorID: doctorID)
        case .selectDateView:
            self.presentSelectDateViewController()
        case .appointmentDetailsView:
            self.presentAppointmentDetailsViewController()
        }
    }
    
    func presentClinicServicesListViewController() {
        let clinicServicesListViewController = clinicServicesListViewControllerFactory()
        navigationController?.pushViewController(clinicServicesListViewController, animated: true)
    }
    
    func presentClinicServiceViewController(serviceID: Int) {
        let clinicServiceViewController = clinicServiceViewControllerFactory(serviceID)
        navigationController?.presentPanModal(clinicServiceViewController)
    }
    
    func presentDoctorsListViewController() {
        let doctorsListViewController = doctorsListViewControllerFactory()
        navigationController?.pushViewController(doctorsListViewController, animated: true)
    }
    
    func presentDoctorViewController(doctorID: Int) {
        let doctorViewController = doctorViewControllerFactory(doctorID)
        navigationController?.pushViewController(doctorViewController, animated: true)
    }
    
    func presentSelectDateViewController() {
        let selectDateViewController = selectDateViewControllerFactory()
        navigationController?.pushViewController(selectDateViewController, animated: true)
    }
    
    func presentAppointmentDetailsViewController() {
        let appointmentDetailsViewController = appointmentDetailsControllerFactory()
        navigationController?.pushViewController(appointmentDetailsViewController, animated: true)
    }
}

/*
 extension MainScreenViewController {
     func bindNavigations() {
         bindOpenLikedDoctorsView()
         bindOpenAllServices()
         bindOpenDoctorsList()
         bindInfoAboutService()
         bindInfoAboutDoctor()
     }
  
     func bindOpenLikedDoctorsView() {
         viewModel
             .$openLikedDoctorsView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 //navigationController?.pushViewController(factory.makeLikedDoctorsViewController(), animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindOpenAllServices() {
         viewModel
             .$openAllServices
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 //navigationController?.pushViewController(factory.makeSelectServicesViewController(isModifying: false, isFromDoctor: viewModel.isFromDoctor, isFromClinicService: viewModel.isFromClinicService, appointmentRequest: viewModel.appointmentRequest), animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindOpenDoctorsList() {
         viewModel
             .$openDoctorsList
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 //navigationController?.pushViewController(factory.makeSelectDoctorViewController(isModifying: false, isFromDoctor: viewModel.isFromDoctor, isFromClinicService: viewModel.isFromClinicService, appointmentRequest: viewModel.appointmentRequest), animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindInfoAboutService() {
         viewModel
             .$openInfoAboutService
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, let serviceID = viewModel.serviceID, open else { return }
                 //navigationController?.presentPanModal(factory.makeInfoAboutServiceViewController(isModifying: false, serviceID: serviceID, isFromDoctor: viewModel.isFromDoctor, isFromClinicService: viewModel.isFromClinicService, isFromMain: true))
             }.store(in: &subscriptions)
     }
     
     func bindInfoAboutDoctor() {
         viewModel
             .$openInfoAboutDoctor
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, let id = viewModel.doctorID, open else { return }
                 //navigationController?.pushViewController(factory.makeInfoAboutDoctorViewController(isModifying: false, doctorID: id, isFromDoctor: viewModel.isFromDoctor, isFromClinicService: viewModel.isFromClinicService, appointmentRequest: viewModel.appointmentRequest), animated: true)
             }.store(in: &subscriptions)
     }
 }
 */

