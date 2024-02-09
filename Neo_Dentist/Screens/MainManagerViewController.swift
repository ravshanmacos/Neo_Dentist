//
//  MainViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/02/24.
//

import UIKit
import Combine

class MainManagerViewController: BaseViewController {
    //MARK: Properties
    private let viewModel: MainManagerViewModel
    
    let launchViewController: LaunchViewController
    var signedInViewController: TabbarController?
    var onboardingViewController: OnboardingViewController?
    
    var subscriptions = Set<AnyCancellable>()
    
    let makeOnboardingViewController: () -> OnboardingViewController
    let makeSignedInViewController: (UserSession) -> TabbarController
    
    //MARK: Methods
    init(viewModel: MainManagerViewModel,
         launchViewController: LaunchViewController,
         onboardingViewControllerFactory: @escaping () -> OnboardingViewController,
         signedInViewControllerFactory: @escaping (UserSession) -> TabbarController
    ) {
        self.viewModel = viewModel
        self.launchViewController = launchViewController
        self.makeOnboardingViewController = onboardingViewControllerFactory
        self.makeSignedInViewController = signedInViewControllerFactory
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeViewModel()
    }
    
    func observeViewModel() {
        let publisher = viewModel.$view.removeDuplicates().eraseToAnyPublisher()
        self.subscribe(to: publisher)
    }
    
    func subscribe(to publisher: AnyPublisher<MainManagerViewState, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] view in
                guard let self else { return }
                self.presentView(view)
            }.store(in: &subscriptions)
    }
}

//MARK: Presenting View Controllers
extension MainManagerViewController {
    func presentView(_ view: MainManagerViewState) {
        switch view {
        case .launching:
            presentLaunching()
        case .onboarding:
            if onboardingViewController?.presentingViewController == nil {
                if presentedViewController.exists {
                    dismiss(animated: true) {[weak self] in
                        self?.presentOnboarding()
                    }
                } else {
                    presentOnboarding()
                }
            }
        case .signedIn(let userSession):
            self.presentSignedIn(userSession: userSession)
        }
    }
    
    func presentLaunching() {
        addFullScreen(addViewController: launchViewController)
    }
    func presentOnboarding() {
        let onboardingViewController = makeOnboardingViewController()
        onboardingViewController.modalPresentationStyle = .fullScreen
        present(onboardingViewController, animated: true) { [weak self] in
            guard let self else { return }
            self.removeViewController(childViewController: self.launchViewController)
            if let signedInViewController {
                self.removeViewController(childViewController: signedInViewController)
                self.signedInViewController = nil
            }
        }
        self.onboardingViewController = onboardingViewController
    }
    func presentSignedIn(userSession: UserSession) {
        removeViewController(childViewController: launchViewController)
        let signedInViewControllerToPresent: TabbarController
        if let vc = self.signedInViewController {
            signedInViewControllerToPresent = vc
        } else {
            signedInViewControllerToPresent = makeSignedInViewController(userSession)
            self.signedInViewController = signedInViewControllerToPresent
        }
        addFullScreen(addViewController: signedInViewControllerToPresent)
        if onboardingViewController?.presentingViewController != nil {
            onboardingViewController = nil
            dismiss(animated: true)
        }
    }
}

