//
//  SignInViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/02/24.
//

import Foundation
import Combine

class SignInViewModel {
    //MARK: Properties
    private let userSessionRepository: UserSessionRepository
    private let signedInResponder: SignedInResponder
    private let goToSignUpNavigator: GoToSignUpNavigator
    private let goToPasswordResetNavigator: GoToPasswordResetNavigator
    
    @Published private(set) var loginInputEnabled = true
    @Published private(set) var passwordInputEnabled = true
    @Published private(set) var signInButtonEnabled = true
    @Published private(set) var signInActivityIndicatorEnabled = false
    
    var login = ""
    var password: Secret = ""
    var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    private var errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository, 
         signedInResponder: SignedInResponder,
         goToSignUpNavigator: GoToSignUpNavigator,
         goToPasswordResetNavigator: GoToPasswordResetNavigator
    ) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
        self.goToSignUpNavigator = goToSignUpNavigator
        self.goToPasswordResetNavigator = goToPasswordResetNavigator
    }
    
    private func indicateSigningIn() {
        loginInputEnabled = false
        passwordInputEnabled = false
        signInButtonEnabled = false
        signInActivityIndicatorEnabled = true
    }
    
    private func indicateErrorSigningIn(_ error: Error) {
        let errorMessage = ErrorMessage(title: "Sign In Failed", message: "Could not sign in.\nPlease try again.")
        errorMessageSubject.send(errorMessage)
        
        loginInputEnabled = true
        passwordInputEnabled = true
        signInButtonEnabled = true
        signInActivityIndicatorEnabled = false
    }
    
    func navigateToSignUp() {
        goToSignUpNavigator.navigateToSignUp()
    }
    
    func navigateToPasswordRecovery() {
        goToPasswordResetNavigator.navigateToPasswordReset()
    }
}

//MARK: Networking
extension SignInViewModel {
    func signInUser() {
        indicateSigningIn()
        userSessionRepository
            .signIn(email: login, password: password)
            .done(signedInResponder.signedIn(to:))
            .catch(indicateErrorSigningIn)
    }
}
