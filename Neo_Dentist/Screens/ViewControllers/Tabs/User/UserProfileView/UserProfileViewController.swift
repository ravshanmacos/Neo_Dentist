//
//  UserProfileViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/01/24.
//

import UIKit
import Combine

protocol UserProfileViewModelFactory {
    func makeUserProfileViewModel() -> UserProfileViewModel
}

class UserProfileViewController: BaseViewController {
    //MARK: Properties
    private let viewModelFactory: UserProfileViewModelFactory
    private let viewModel: UserProfileViewModel
    
    private let rootView: UserProfileRootView
    private var subscriptions = Set<AnyCancellable>()
    
    
    //MARK: Methods
    init(viewModelFactory: UserProfileViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeUserProfileViewModel()
        self.rootView = UserProfileRootView(viewModel: viewModel)
        super.init()
        bindNavigations()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getUserProfile()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleToLeft("Профиль 🦷")
    }
    
    private func cancelAppoimentRecordTapped() {
        print("First Button Tapped")
        if let cardIndex = viewModel.cardIndex {
            viewModel.appointments.remove(at: cardIndex)
        }
        guard let id = viewModel.appointmentID else { return }
        viewModel.deleteAppointment(id: id)
    }
    
    private func logoutTapped() {
        print("logoutTapped")
        UserDefaults.standard.setLoggedIn(value: false)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
    }
}

//MARK: Navigations
private extension UserProfileViewController {
    func bindNavigations() {
        bindOpenEditProfileView()
        bindOpenCancelPandModal()
        bindLogoutPandModal()
    }
    
    func bindOpenEditProfileView() {
        viewModel
            .$openEditProfileView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                //navigationController?.pushViewController(factory.makeEditUserProfileViewController(), animated: true)
            }.store(in: &subscriptions)
    }
    
    func bindOpenCancelPandModal() {
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
                navigationController?.presentPanModal(twoActionSheetVC)
            }.store(in: &subscriptions)
    }
    
    func bindLogoutPandModal() {
        viewModel
            .$logout
            .receive(on: DispatchQueue.main)
            .sink {[weak self] logout in
                guard let self, logout else { return }
                let twoActionSheetVC = TwoActionSheetViewController()
                twoActionSheetVC.sheetImageView.image = R.image.tooth_icon_19()
                twoActionSheetVC.sheetLabel.text = "Вы уверены, что хотите выйти?"
                twoActionSheetVC.sheetFirstActionButton.setTitle("Выйти", for: .normal)
                twoActionSheetVC.sheetSecondActionButton.setTitle("Назад", for: .normal)
                twoActionSheetVC.firstActionTapped = logoutTapped
                navigationController?.presentPanModal(twoActionSheetVC)
            }.store(in: &subscriptions)
    }
}
