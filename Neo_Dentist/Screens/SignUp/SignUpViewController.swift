//
//  SignUpViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import UIKit
import Combine

protocol SignUpViewModelFactory {
    func makeSignUpViewModel() -> SignUpViewModel
}

class SignUpViewController: BaseViewController {
    private let viewModel: SignUpViewModel
    private let viewModelFactory: SignUpViewModelFactory
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModelFactory: SignUpViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSignUpViewModel()
        super.init()
        bindOpenConfirmByMessage()
    }
    
    override func loadView() {
        super.loadView()
        view = SignUpRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
    }
}

//MARK: Bind Navigation
extension SignUpViewController {
    func bindOpenConfirmByMessage() {
        /*
         viewModel
             .$openConfirmByMessage
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 navigationController?.pushViewController(factory.makeConfirmByMessageViewController(byEmail: false, request: SendVerificationCodeRequest(username: "", email: "")), animated: true)
             }.store(in: &subscriptions)
         */
    }
}
