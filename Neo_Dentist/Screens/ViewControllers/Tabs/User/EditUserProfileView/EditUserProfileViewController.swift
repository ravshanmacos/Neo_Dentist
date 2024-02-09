//
//  EditUserProfileViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class EditUserProfileViewController: BaseViewController {
    private let viewModel: EditUserProfileViewModel
    private let rootView: EditUserProfileRootView
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: EditUserProfileViewModel) {
        self.viewModel = viewModel
        self.rootView = EditUserProfileRootView(viewModel: viewModel)
        super.init()
        bindNavigations()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(text: "Редактировать профиль")
        setBackButton()
    }
    
    private func deleteAccountTapped() {
        print("deleteAccountTapped")
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
    }
    
    private func cancelDeleteAccountTapped() {
        print("cancelDeleteAccountTapped")
        viewModel.deleteUserProfile()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "logout"), object: nil)
    }
    
    private func continueButtonTapped() {
        print("continueButtonTapped")
        navigationController?.popToRootViewController(animated: true)
    }
}

private extension EditUserProfileViewController {
    func bindNavigations() {
        bindOpenCancelPandModal()
        bindOpenRootView()
    }
    
    func bindOpenCancelPandModal() {
        viewModel
            .$openDeleteActionPanModal
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                let twoActionSheetVC = TwoActionSheetViewController()
                twoActionSheetVC.sheetImageView.image = R.image.tooth_icon_18()
                twoActionSheetVC.sheetLabel.text = "Вы уверены, что хотите удалить \nаккаунт?"
                twoActionSheetVC.sheetFirstActionButton.setTitle("Удалить аккаунт", for: .normal)
                twoActionSheetVC.sheetSecondActionButton.setTitle("Назад", for: .normal)
                twoActionSheetVC.firstActionTapped = deleteAccountTapped
                twoActionSheetVC.secondActionTapped = cancelDeleteAccountTapped
                navigationController?.presentPanModal(twoActionSheetVC)
            }.store(in: &subscriptions)
    }
    
    func bindOpenRootView() {
        viewModel
            .$openRootView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                let singleActionSheetVC = SingleActionSheetViewController()
                singleActionSheetVC.sheetImageView.image = R.image.tooth_icon_20()
                singleActionSheetVC.sheetLabel.text = "Ваши данные успешно изменены!"
                singleActionSheetVC.sheetFirstActionButton.setTitle("Продолжить", for: .normal)
                singleActionSheetVC.actionTapped = continueButtonTapped
                navigationController?.presentPanModal(singleActionSheetVC)
            }.store(in: &subscriptions)
    }
}
