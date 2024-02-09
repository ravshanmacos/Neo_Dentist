//
//  LaunchViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import Combine

class LaunchViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModel: LaunchViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(launchViewModelFactory: LaunchViewModelFactory) {
        self.viewModel = launchViewModelFactory.makeLaunchViewModel()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = LaunchRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeErrorMessages()
    }
    
    func observeErrorMessages() {
        viewModel
            .errorMessages
            .receive(on: DispatchQueue.main)
            .sink {[weak self] errorMessage in
                guard let self else { return }
                present(errorMessage: errorMessage, errorPresentation: viewModel.errorPresentation)
            }.store(in: &subscriptions)
    }
    
}

protocol LaunchViewModelFactory {
    func makeLaunchViewModel() -> LaunchViewModel
}
