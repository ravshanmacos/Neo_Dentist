//
//  LaunchViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import Combine

class LaunchViewModel {
    
    //MARK: Properties
    let userSessionRepository: UserSessionRepository
    let notSignedInResponder: NotSignedInResponder
    let signedInResponder: SignedInResponder
    
    var errorMessages: AnyPublisher<ErrorMessage, Never> {
        return errorMessageSubject.eraseToAnyPublisher()
    }
    
    private let errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    let errorPresentation = PassthroughSubject<ErrorPresentation?, Never>()
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(userSessionRepository: UserSessionRepository, notSignedInResponder: NotSignedInResponder, signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.notSignedInResponder = notSignedInResponder
        self.signedInResponder = signedInResponder
    }
    
    func loadUserSession() {
        userSessionRepository
            .readUserSession()
            .done(goToNextScreen(userSession:))
            .catch { error in
                let errorMessage = ErrorMessage(title: "Sign In Error", message: "Sorry, we couldn't determine if you are already signed in. Please sign in or sign up.")
                self.present(errorMessage: errorMessage)
            }
    }
    
    func present(errorMessage: ErrorMessage) {
        goToNextScreenAfterErrorPresentation()
        errorMessageSubject.send(errorMessage)
    }
    
    func goToNextScreenAfterErrorPresentation() {
        errorPresentation
            .filter{ $0 == .dismissed }
            .prefix(1)
            .sink {[weak self] _ in
                guard let self else { return }
                goToNextScreen(userSession: nil)
            }.store(in: &subscriptions)
    }
    
    func goToNextScreen(userSession: UserSession?) {
        switch userSession {
        case .none:
            notSignedInResponder.notSignedIn()
        case .some(let userSession):
            signedInResponder.signedIn(to: userSession)
        }
    }
}
