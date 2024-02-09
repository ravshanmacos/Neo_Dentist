//
//  InfoFromUserViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit
import Combine

protocol UserInfoViewModelFactory {
    func makeUserInfoViewModel() -> UserInfoViewModel
}

class UserInfoViewController: BaseViewController {
    
    //MARK: Properties
    
    private let viewModelFactory: UserInfoViewModelFactory
    private let viewModel: UserInfoViewModel
    private let rootView: UserInfoRootView
    private let appointmentRequest: MakeAppointmentRequest
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModelFactory: UserInfoViewModelFactory,
         appointmentRequest: MakeAppointmentRequest) {
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeUserInfoViewModel()
        self.appointmentRequest = appointmentRequest
        self.rootView = UserInfoRootView(viewModel: viewModel)
        super.init()
        bindOpenCheckView()
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
        setTitle(text: "Информация о Вас")
        setBackButton()
        
        print(appointmentRequest)
        viewModel.appointmentRequest = appointmentRequest
    }
}

//MARK: Navigations
extension UserInfoViewController {
    func bindOpenCheckView() {
       /*
        viewModel
            .$openCheckView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, let appointmentResponse = viewModel.appointmentResponse, open else { return }
                navigationController?.pushViewController(factory.makeCheckViewController(appoinmentResponse: appointmentResponse, isFromTab: false), animated: true)
            }.store(in: &subscriptions)
        */
    }
}
