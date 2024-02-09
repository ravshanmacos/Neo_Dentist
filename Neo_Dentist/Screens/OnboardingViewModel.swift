//
//  OnboardingViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/02/24.
//

import Combine

typealias OnboardingNavigationAction = NavigationAction<OnboardingViewState>

class OnboardingViewModel: GoToSignUpNavigator, GoToPasswordResetNavigator, GoToConfirmByOtpNavigator, GoToCreatePasswordNavigator {
    
    //MARK: Properties
    @Published private(set) var navigationAction: OnboardingNavigationAction = .present(view: .signIn)
    
    //MARK: Methods
    func navigateToSignUp() {
        navigationAction = .present(view: .signUp)
    }
    
    func navigateToPasswordReset() {
        navigationAction = .present(view: .passwordReset)
    }
    
    func navigateToConfirmByOtp() {
        navigationAction = .present(view: .confirmByOtp)
    }
    
    func navigateToCreatePassword() {
        navigationAction = .present(view: .createNewPassword)
    }
    
    func presentedUI(onboardingViewState: OnboardingViewState) {
        navigationAction = .presented(view: onboardingViewState)
    }
}
