//
//  PasswordResetViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import Foundation
import Combine

class PasswordResetViewModel: ViewModelProtocol {
    
    //MARK: Properties
    @Published private(set) var loginInputEnabled = true
    @Published private(set) var emailInputEnabled = true
    @Published private(set) var nextButtonEnabled = true
    
    @Published var openConfirmByMessage = false
    
    var login: String = ""
    var email: String = ""
    
    private let userSessionRepository: UserSessionRepository
    private let goToConfirmByOtpNavigator: GoToConfirmByOtpNavigator
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository,
         goToConfirmByOtpNavigator: GoToConfirmByOtpNavigator) {
        self.userSessionRepository = userSessionRepository
        self.goToConfirmByOtpNavigator = goToConfirmByOtpNavigator
    }
    
    @objc func verifyButtonTapped(_ sender: Any) {
        sendVerificationCode()
    }
    
    private func sendVerificationCode() {
        goToConfirmByOtpNavigator.navigateToConfirmByOtp()
        /*
         guard login != "", email != "" else { return }
         let request = SendVerificationCodeRequest(username: login, email: email)
         authService.sendVerificationCode(sendVerificationRequest: request) { [weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 UserDefaults.standard.setValue(email, forKey: UserDefaultsKeys.email)
                 UserDefaults.standard.setValue(data.userID, forKey: UserDefaultsKeys.userID)
                 self.openConfirmByMessage = true
             case .failure(let error):
                 if let error = error.asAFError {
                     switch error.responseCode {
                     case 400:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Неправильный логин или пароль"))
                     case 404:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Пользователь не найден!"))
                     case 406:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Неправильный логин или пароль"))
                     default:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Что-то пошло не так, попробуйте еще раз!"))
                         return
                     }
                 }
             }
         }
         */
    }
}

