//
//  CreateNewPasswordViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import UIKit
import Combine

protocol CreateNewPasswordViewModelFactory {
    func makeCreateNewPasswordViewModel() -> CreateNewPasswordViewModel
}

class CreateNewPasswordViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: CreateNewPasswordViewModelFactory
    private let viewModel: CreateNewPasswordViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModelFactory: CreateNewPasswordViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeCreateNewPasswordViewModel()
        super.init()
        bindSuccessMessageToViewController()
    }
    
    override func loadView() {
        super.loadView()
        view = CreateNewPasswordRootView(viewModel: viewModel)
    }
    
    func openMainView() {
        print("open main view")
        //navigationController?.pushViewController(createNewPasswordFactory.makeTabBarController(), animated: true)
    }
    
    deinit {
        print("Deinitialized")
    }
}

private extension CreateNewPasswordViewController {
    func bindSuccessMessageToViewController() {
        viewModel
            .$openSuccessPanModal
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                let singleActionSheetVC = SingleActionSheetViewController()
                singleActionSheetVC.sheetImageView.image = R.image.tooth_icon_16()
                singleActionSheetVC.sheetLabel.text = "Ура! Ваш пароль успешно изменен!"
                singleActionSheetVC.sheetFirstActionButton.setTitle("Продолжить", for: .normal)
                singleActionSheetVC.actionTapped = openMainView
                navigationController?.presentPanModal(singleActionSheetVC)
            }.store(in: &subscriptions)
    }
}

