//
//  AppointmentHistoriesViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import UIKit
import Combine

protocol AppointmentHistoriesViewModelFactory {
    func makeAppointmentHistoriesViewModel() -> AppointmentHistoriesViewModel
}

class AppointmentHistoriesViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: AppointmentHistoriesViewModelFactory
    private let viewModel: AppointmentHistoriesViewModel
    private let rootView: AppointmentHistoriesRootView
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    //MARK: Methods
    init(viewModelFactory: AppointmentHistoriesViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeAppointmentHistoriesViewModel()
        self.rootView = AppointmentHistoriesRootView(viewModel: viewModel)
        super.init()
        bindOpenCancelRecordView()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        viewModel.getAppointments(status: AppointmentStatus.pending.rawValue)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func cancelAppoimentRecordTapped() {
        guard let id = viewModel.appointmentID else { return }
        viewModel.deleteAppointment(id: id)
    }
    
    private func backTapped() {
        print("Second Button Tapped")
    }
}

//MARK: Navigations
private extension AppointmentHistoriesViewController {
    func bindOpenCancelRecordView() {
        viewModel
            .$openCancelView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                let twoActionSheetVC = TwoActionSheetViewController()
                twoActionSheetVC.sheetImageView.image = R.image.tooth_icon_18()
                twoActionSheetVC.sheetLabel.text = "Вы уверены, что хотите отменить свою запись на прием?"
                twoActionSheetVC.sheetFirstActionButton.setTitle("Отменить запись", for: .normal)
                twoActionSheetVC.sheetSecondActionButton.setTitle("Назад", for: .normal)
                twoActionSheetVC.firstActionTapped = cancelAppoimentRecordTapped
                twoActionSheetVC.secondActionTapped = backTapped
                navigationController?.presentPanModal(twoActionSheetVC)
            }.store(in: &subscriptions)
    }
}
