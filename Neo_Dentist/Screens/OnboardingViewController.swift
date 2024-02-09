//
//  OnboardingViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/02/24.
//

import UIKit
import Combine

class OnboardingViewController: BaseNavigationController {
    //MARK: Properties
    private let viewModel: OnboardingViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //child view controllers
    private var signInViewController: SignInViewController
    private var signUpViewController: SignUpViewController
    private var passwordResetViewController: PasswordResetViewController
    private var confirmByMessageViewController: ConfirmByMessageViewController
    private var createNewPasswordViewController: CreateNewPasswordViewController
    
    init(viewModel: OnboardingViewModel, 
         signInViewController: SignInViewController,
         signUpViewController: SignUpViewController,
         passwordResetViewController: PasswordResetViewController,
         confirmByMessageViewController: ConfirmByMessageViewController,
         createNewPasswordViewController: CreateNewPasswordViewController) {
        self.viewModel = viewModel
        self.signInViewController = signInViewController
        self.signUpViewController = signUpViewController
        self.passwordResetViewController = passwordResetViewController
        self.confirmByMessageViewController = confirmByMessageViewController
        self.createNewPasswordViewController = createNewPasswordViewController
        super.init()
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observeNavigationAction()
    }
}

//MARK: Observing & Reacting
private extension OnboardingViewController {
    func observeNavigationAction() {
        let publisher = viewModel.$navigationAction.eraseToAnyPublisher()
        subscribe(to: publisher)
    }
    
    func subscribe(to publisher: AnyPublisher<OnboardingNavigationAction, Never>) {
        publisher
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink {[weak self] action in
                guard let self else { return }
                self.respond(to: action)
            }.store(in: &subscriptions)
    }
    
    func respond(to navigationAction: OnboardingNavigationAction) {
        switch navigationAction {
        case .present(let view):
            self.present(view: view)
        case .presented:
            break
        }
    }
    
    func present(view: OnboardingViewState) {
        switch view {
        case .signIn:
            self.presentSignIn()
        case .signUp:
            self.presentSignUp()
        case .passwordReset:
            self.presentPasswordReset()
        case .confirmByOtp:
            self.presentConfirmByOtp()
        case .createNewPassword:
            self.presentCreateNewPassword()
        }
    }
    
    func presentSignIn() {
        pushViewController(signInViewController, animated: true)
    }
    func presentSignUp() {
        pushViewController(signUpViewController, animated: true)
    }
    func presentPasswordReset() {
        pushViewController(passwordResetViewController, animated: true)
    }
    
    func presentConfirmByOtp() {
        pushViewController(confirmByMessageViewController, animated: true)
    }
    
    func presentCreateNewPassword() {
        pushViewController(createNewPasswordViewController, animated: true)
    }
}

extension OnboardingViewController {
    func hideAndShowNavigationBarIfNeeded(for view: OnboardingViewState, animated: Bool) {
        if view.hidesNavigationBar() {
            hideNavigationBar(animated: animated)
        } else {
            showNavigationBar(animated: animated)
        }
    }
    
    func hideNavigationBar(animated: Bool) {
        if animated {
            transitionCoordinator?.animate(alongsideTransition: { context in
                self.setNavigationBarHidden(true, animated: true)
            })
        } else {
            self.setNavigationBarHidden(true, animated: false)
        }
    }
    
    func showNavigationBar(animated: Bool) {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}

extension OnboardingViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let viewToBeShown = onboardingView(associatedWith: viewController) else { return }
        hideAndShowNavigationBarIfNeeded(for: viewToBeShown, animated: animated)
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        //Onboarding view controller updates state anytime a view controller gets shown on the navigation stack.
        guard let shownView = onboardingView(associatedWith: viewController) else { return }
        viewModel.presentedUI(onboardingViewState: shownView)
    }
}

extension OnboardingViewController {
    func onboardingView(associatedWith viewController: UIViewController) -> OnboardingViewState? {
        switch viewController {
        case is SignInViewController:
            return .signIn
        case is SignUpViewController:
            return .signUp
        case is PasswordResetViewController:
            return .passwordReset
        case is ConfirmByMessageViewController:
            return .confirmByOtp
        case is CreateNewPasswordViewController:
            return .createNewPassword
        default:
            assertionFailure("Encountered unexpected child view controller type in OnboardingViewController")
            return nil
        }
    }
}
