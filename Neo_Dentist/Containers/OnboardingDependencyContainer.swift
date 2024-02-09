//
//  OnboardingDependencyContainer.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/02/24.
//

import Foundation

class OnboardingDependencyContainer {
    
    //MARK: Properties
    let sharedUserSessionRepository: UserSessionRepository
    let sharedMainViewModel: MainManagerViewModel
    
    let sharedOnboardingViewModel: OnboardingViewModel
    
    //MARK: Methods
    
    init(appDependencyContainer: AppDependencyContainer) {
        func makeOboardingViewModel() -> OnboardingViewModel {
            return OnboardingViewModel()
        }
        
        self.sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        self.sharedOnboardingViewModel = makeOboardingViewModel()
    }
    
    func makeOnboardingViewController() -> OnboardingViewController {
        let signInViewController = makeSignInViewController()
        let signUpViewController = makeSignUpViewController()
        let passwordResetViewController = makePasswordResetViewController()
        let confirmByOtpViewController = makeConfirmByOtpViewController()
        let createNewPasswordViewController = makeCreateNewPasswordViewController()
        
        return OnboardingViewController(viewModel: sharedOnboardingViewModel,
                                        signInViewController: signInViewController,
                                        signUpViewController: signUpViewController,
                                        passwordResetViewController: passwordResetViewController,
                                        confirmByMessageViewController: confirmByOtpViewController,
                                        createNewPasswordViewController: createNewPasswordViewController)
    }
    
    //Sign In
    func makeSignInViewController() -> SignInViewController {
        return SignInViewController(viewModelFactory: self)
    }
    
    func makeSignInViewModel() -> SignInViewModel {
        return SignInViewModel(userSessionRepository: sharedUserSessionRepository, signedInResponder: sharedMainViewModel, goToSignUpNavigator: sharedOnboardingViewModel, goToPasswordResetNavigator: sharedOnboardingViewModel)
    }
    
    //Sign Up
    func makeSignUpViewController() -> SignUpViewController {
        return SignUpViewController(viewModelFactory: self)
    }
    
    func makeSignUpViewModel() -> SignUpViewModel {
        return SignUpViewModel(userSessionRepository: sharedUserSessionRepository, signedInResponder: sharedMainViewModel)
    }
    
    //Password Reset
    func makePasswordResetViewController() -> PasswordResetViewController {
        return PasswordResetViewController(viewModelFactory: self)
    }
    
    func makePasswordResetViewModel() -> PasswordResetViewModel {
        return PasswordResetViewModel(userSessionRepository: sharedUserSessionRepository, goToConfirmByOtpNavigator: sharedOnboardingViewModel)
    }
    
    //ConfirmByOtp
    func makeConfirmByOtpViewController() -> ConfirmByMessageViewController {
        return ConfirmByMessageViewController(viewModelFactory: self)
    }
    
    func makeConfirmByOtpViewModel() -> ConfirmByMessageViewModel {
        return ConfirmByMessageViewModel(userSessionRepository: sharedUserSessionRepository,
                                         gotoCreatePasswordNavigator: sharedOnboardingViewModel,
                                         byEmail: true)
    }
    
    //CreateNewPassword
    func makeCreateNewPasswordViewController() -> CreateNewPasswordViewController {
        return CreateNewPasswordViewController(viewModelFactory: self)
    }
    
    func makeCreateNewPasswordViewModel() -> CreateNewPasswordViewModel {
        return CreateNewPasswordViewModel(userSessionRepository: sharedUserSessionRepository, 
                                          signedInResponder: sharedMainViewModel)
    }
    
}

extension OnboardingDependencyContainer: SignInViewModelFactory, SignUpViewModelFactory, PasswordResetViewModelFactory, ConfirmByOtpViewModelFactory, CreateNewPasswordViewModelFactory {}
