//
//  SignInViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import Foundation
import Combine

protocol SignInViewModelFactory {
    func makeSignInViewModel() -> SignInViewModel
}

class SignInViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModel: SignInViewModel
    private let viewModelFactory: SignInViewModelFactory
    
    private var signInRootView: SignInRootView {
        return view as! SignInRootView
    }
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModelFactory: SignInViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSignInViewModel()
        super.init()
        //bindNavigations()
    }
    
    override func loadView() {
        view = SignInRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    private func observeErrorMessages() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] errorMessage in
                guard let self else { return }
                self.present(errorMessage: errorMessage)
            }.store(in: &subscriptions)
    }
}

extension SignInViewController {
    
    /*
     func bindNavigations() {
         bindOpenCurrentView()
         bindOpenMainView()
         bindSignUp()
         bindPasswordRecovery()
     }
     
     func bindOpenCurrentView() {
         viewModel
             .$openCurrentView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 navigationController?.popToViewController(self, animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindOpenMainView() {
         viewModel
             .$openMainView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 navigationController?.pushViewController(signInFactory.makeTabBarController(), animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindPasswordRecovery() {
         viewModel
             .$openPasswordRecoveryView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 navigationController?.pushViewController(signInFactory.makeVerifyUserViewController(), animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindSignUp() {
         viewModel
             .$openSignUpView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 navigationController?.pushViewController(signInFactory.makeSignUpViewController(), animated: true)
             }.store(in: &subscriptions)
     }
     */
}
