//
//  PasswordResetViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import UIKit
import Combine

protocol PasswordResetViewModelFactory {
    func makePasswordResetViewModel() -> PasswordResetViewModel
}

class PasswordResetViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModel: PasswordResetViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    private let viewModelFactory: PasswordResetViewModelFactory
    
    init(viewModelFactory: PasswordResetViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makePasswordResetViewModel()
        super.init()
        bindOpenConfirmByMessage()
    }
    
    override func loadView() {
        view = PasswordResetRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
    }
}

extension PasswordResetViewController {
    
    func bindOpenConfirmByMessage() {
        /*
         viewModel
             .$openConfirmByMessage
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 let request = SendVerificationCodeRequest(username: viewModel.login, email: viewModel.email)
                 navigationController?.pushViewController(verifyUserFactory.makeConfirmByMessageViewController(byEmail: true, request: request), animated: true)
             }.store(in: &subscriptions)
         */
    }
}
