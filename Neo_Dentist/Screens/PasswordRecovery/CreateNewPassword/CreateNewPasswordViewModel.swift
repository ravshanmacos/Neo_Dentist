//
//  CreateNewPasswordViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import Foundation
import Combine

class CreateNewPasswordViewModel {
    var password: String = ""
    var confirmPassword: String = ""
    
    var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    
    private let errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    
    @Published private(set) var passwordInputEnabled = true
    @Published private(set) var passwordConfirmEnabled = true
    @Published private(set) var isTextfieldsFilled = false
    @Published private(set) var nextButtonEnabled = false
    
    @Published private(set) var openMainView = false
    @Published private(set) var openSuccessPanModal = false
    
    private let userSessionRepository: UserSessionRepository
    private let signedInResponder: SignedInResponder
    
    init(userSessionRepository: UserSessionRepository,
         signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
    }
    
    @objc func createNewPasswordButtonTapped(_ sender: Any) {
        print("password: \(password)")
        print("confirm password: \(confirmPassword)")
        guard password != "", confirmPassword != "", password == confirmPassword else { return }
        let request = PasswordChangeRequest(password: password, confirmPassword: confirmPassword)
        changePassword(request: request)
        
    }
    
    @objc func navigateToMainViewController() {
        openMainView = true
    }
    
    func changeButtonState(_ isEmpty: Bool) {
        nextButtonEnabled = !isEmpty
    }

}

extension CreateNewPasswordViewModel {
    func changePassword(request: PasswordChangeRequest) {
        let account = NewAccount(fullname: "Ravshanbek",
                                 nickname: "Roma9805", email: "rtursunbaev9822@gmail.com",
                                 phoneNumber: "+998908399805", password: "ravshan9805")
        userSessionRepository
            .signUp(newAccount: account)
            .done(signedInResponder.signedIn(to:))
            .catch { error in
                print(error)
            }
        
        /*
         authNetworkService.changePassword(request: request) {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 print(data.message)
                 UserDefaults.standard.setLoggedIn(value: true)
                 openSuccessPanModal = true
             case .failure(let error):
                 if let error = error.asAFError {
                     switch error.responseCode {
                     case 400:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Поля пароля не совпадают"))
                     case 406:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Неверные данные!"))
                     default:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Что-то пошло не так. Пожалуйста, \nпопробуйте еще раз!"))
                     }
                 }
             }
         }
         */
    }
}
