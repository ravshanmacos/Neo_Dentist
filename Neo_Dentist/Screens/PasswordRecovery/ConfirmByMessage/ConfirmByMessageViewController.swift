//
//  ConfirmByMessageViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import UIKit
import Combine

protocol ConfirmByOtpViewModelFactory {
    func makeConfirmByOtpViewModel() -> ConfirmByMessageViewModel
}

class ConfirmByMessageViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: ConfirmByOtpViewModelFactory
    private let viewModel: ConfirmByMessageViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModelFactory: ConfirmByOtpViewModelFactory) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeConfirmByOtpViewModel()
        super.init()
        bindOpenCreateNewPassword()
        bindOpenMainView()
    }
    
    override func loadView() {
        view = ConfirmByMessageRootView(viewModel: viewModel)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if !viewModel.byEmail {
            navigationController?.setNavigationBarHidden(true, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        navigationController?.navigationBar.isHidden = false
    }
    
    func bindOpenCreateNewPassword() {
        /*
         viewModel
             .$openCreateNewPassword
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 navigationController?.pushViewController(confirmByMessageFactory.makeCreateNewPasswordViewController(), animated: true)
             }.store(in: &subscriptions)
         */
    }
    
    func bindOpenMainView() {
       /*
        viewModel
            .$openMainView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                navigationController?.pushViewController(confirmByMessageFactory.makeTabBarController(), animated: true)
            }.store(in: &subscriptions)
        */
    }
}

