//
//  SignUpViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import Combine

class SignUpViewModel {
    
    //MARK: Properties
    @Published private(set) var firstnameEnabled = true
    @Published private(set) var lastnameEnabled = true
    @Published private(set) var loginEnabled = true
    @Published private(set) var emailEnabled = true
    @Published private(set) var phoneNumberEnabled = true
    @Published private(set) var passwordEnabled = true
    @Published private(set) var confiPasswordEnabled = true
    @Published private(set) var nextButtonEnabled = false
    
    @Published var invalidEmail = false
    @Published var invalidPassword = false
    @Published var passwordsDidNotMatch = false
    
    @Published var openConfirmByMessage = false
    
    var firstname: String = ""
    var lastname: String = ""
    var login: String = ""
    var email: String = ""
    var phoneNumber: String = ""
    var password: String = ""
    var confirmPassword: String = ""

    private let userSessionRepository: UserSessionRepository
    private let signedInResponder: SignedInResponder
    
    //MARK: Methods
    init(userSessionRepository: UserSessionRepository, signedInResponder: SignedInResponder) {
        self.userSessionRepository = userSessionRepository
        self.signedInResponder = signedInResponder
    }
    
    func enableNextButton() {
        nextButtonEnabled = true
    }
    
    func disableNextButton() {
        nextButtonEnabled = false
    }
    
    @objc func nextButtonTapped() {
        nextButtonEnabled = false
        guard isFieldsValid() else { nextButtonEnabled = true; return }
        UserDefaults.standard.setValue(firstname, forKey: UserDefaultsKeys.firstName)
        UserDefaults.standard.setValue(lastname, forKey: UserDefaultsKeys.lastName)
        UserDefaults.standard.setValue(login, forKey: UserDefaultsKeys.username)
        UserDefaults.standard.setValue(email, forKey: UserDefaultsKeys.email)
        UserDefaults.standard.setValue(phoneNumber, forKey: UserDefaultsKeys.phoneNumber)
       signUp()
    }
    
    func isFieldsValid() -> Bool {
        
        if !email.isValidEmail() {
            invalidEmail = true
            return false
        }
        
        if !password.isValidPassword() {
            invalidPassword = true
            return false
        }
        
        if password != confirmPassword {
            passwordsDidNotMatch = true
            return false
        }
        return true
    }
}

//MARK: Networking
extension SignUpViewModel {
    func signUp() {
        /*
         let signUpRequest = SignUpRequest(firstname: firstname, lastname: lastname, username: login, email: email, phoneNumber: phoneNumber.removeSpacesFromString(), password: password, confirmPassword: confirmPassword)
         authService.sigUp(signUpRequestModel: signUpRequest) {[weak self] response in
             guard let self else { return }
             switch response {
             case .success(let data):
                 UserDefaults.standard.setValue(phoneNumber, forKey: UserDefaultsKeys.phoneNumber)
                 UserDefaults.standard.setValue(email, forKey: UserDefaultsKeys.email)
                 UserDefaults.standard.setValue(data.userID, forKey: UserDefaultsKeys.userID)
                 openConfirmByMessage = true
             case .failure(let error):
                 print(error)
                 self.nextButtonEnabled = true
             }
         }
         */
    }
}
