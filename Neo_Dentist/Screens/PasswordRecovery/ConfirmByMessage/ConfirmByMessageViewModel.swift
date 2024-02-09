//
//  ConfirmByMessageViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import Foundation
import Combine

class ConfirmByMessageViewModel: ViewModelProtocol {
    
    //MARK: Properties
    @Published private(set) var confirmButtonEnabled = true
    @Published private(set) var sendVerificationEnabled = true
    @Published private(set) var seconds = 60
    
    @Published private(set) var openCreateNewPassword = false
    @Published private(set) var openMainView = false
    
    private var confirmCode: Int?
    private var timer = Timer()
    
    private let userSessionRepository: UserSessionRepository
    private let gotoCreatePasswordNavigator: GoToCreatePasswordNavigator
    
    let byEmail: Bool
    let userID = UserDefaults.standard.integer(forKey: UserDefaultsKeys.userID)
    
    //MARK: methods
    init(userSessionRepository: UserSessionRepository,
         gotoCreatePasswordNavigator: GoToCreatePasswordNavigator,
         byEmail: Bool) {
        self.userSessionRepository = userSessionRepository
        self.gotoCreatePasswordNavigator = gotoCreatePasswordNavigator
        self.byEmail = byEmail
    }
    
    func setConfirmCode(_ code: String) {
        confirmCode = Int(code)
        confirmButtonEnabled = true
    }
    
    @objc func sendVerificationCodeTapped() {
         if byEmail {
             sendVerificationCode()
             sendVerificationEnabled = false
         }
    }
    
    @objc func verifyCode(_ sender: Any) {
        if byEmail {
            verifyCode()
        } else {
            verifyWithNumber()
        }
        
    }
    
}

//MARK: Timer
private extension ConfirmByMessageViewModel {
    func start() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc private func timerAction(){
        if seconds > 0 {
            seconds -= 1
        } else {
            timer.invalidate()
            print("time finished")
            sendVerificationEnabled = true
        }
       
    }
}

//MARK: Networking
private extension ConfirmByMessageViewModel {
    func verifyWithNumber() {
      /*
       guard let confirmCode else { return }
       authService.verifyPersonWithVerificationCode(with: userID, code: confirmCode) {[weak self] result in
           guard let self else { return }
           switch result {
           case .success(let data):
               print(data)
               KeychainNeoDentist.setToken(value: data.access, key: KeychainConstants.accessToken)
               KeychainNeoDentist.setToken(value: data.refresh, key: KeychainConstants.refreshToken)
               if byEmail {
                   openCreateNewPassword = true
               } else {
                   UserDefaults.standard.setLoggedIn(value: true)
                   openMainView = true
               }
           case .failure(let failure):
               print(failure)
           }
       }
       */
    }
    
    func verifyCode() {
        gotoCreatePasswordNavigator.navigateToCreatePassword()
        /*
         guard let confirmCode else { return }
         authService.verifyPasswordVerificationCode(with: userID, code: confirmCode) {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 print(data)
                 KeychainNeoDentist.setToken(value: data.access, key: KeychainConstants.accessToken)
                 KeychainNeoDentist.setToken(value: data.refresh, key: KeychainConstants.refreshToken)
                 if byEmail {
                     openCreateNewPassword = true
                 } else {
                     openMainView = true
                 }
             case .failure(let error):
                 if let error = error.asAFError {
                     switch error.responseCode {
                     case 404:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Код не найден или Пользователь не найден"))
                     case 406:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Неверный код!"))
                     case 422:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Время действия кода истекло"))
                     default:
                         errorMessageSubject.send(ErrorMessage(title: "", message: "Что-то пошло не так. Пожалуйста, \nпопробуйте еще раз!"))
                     }
                 }
             }
         }
         */
    }
    
    
    func sendVerificationCode() {
       /*
        authService.sendVerificationCode(sendVerificationRequest: request) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                start()
            case .failure(let error):
                print(error)
            }
        }
        */
    }
}
