//
//  SignInViewModelOld.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import Foundation
import Combine

class SignInViewModelOld {
    
    //MARK: Properties
    var login: String = ""
    var password: String = ""
    var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    private let errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    
    @Published private(set) var loginInputEnabled = true
    @Published private(set) var passwordInputEnabled = true
    @Published private(set) var signInButtonEnabled = true
    @Published private(set) var signInActivityIndicatorAnimating = false
    
    @Published private(set) var openMainView = false
    @Published private(set) var openPasswordRecoveryView = false
    @Published private(set) var openSignUpView = false
    
    @Published private(set) var openCurrentView = false
    
    private let authService: AuthNetworkService
    private let userNetworkService: UserNetworkService
    
    //MARK: Methods
    init(service: AuthNetworkService, userNetworkService: UserNetworkService) {
        self.authService = service
        self.userNetworkService = userNetworkService
        setupListeners()
    }
    
    private func setupListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(logoutTapped),
                                               name: NSNotification.Name ("logout"), object: nil)
    }
    
    func indicateSigningIn() {
        loginInputEnabled = false
        passwordInputEnabled = false
        signInButtonEnabled = false
        signInActivityIndicatorAnimating = true
    }
    
    func indicateErrorSigningIn(_ error: Error) {
        loginInputEnabled = true
        passwordInputEnabled = true
        signInButtonEnabled = true
        signInActivityIndicatorAnimating = false

        var errorMessage = ErrorMessage(title: "", message: "Не удалось войти.\nПовторите попытку.")
        if let error = error.asAFError {
            switch error.responseCode {
            case 401:
                errorMessage = ErrorMessage(title: "", message: "не удалось войти, \nпожалуйста, проверьте и повторите попытку!")
            default:
                return
            }
        }
        
        errorMessageSubject.send(errorMessage)
    }
    
    func checkEmptyFields() -> Bool {
        if login.isEmpty || password.isEmpty {
            errorMessageSubject.send(ErrorMessage(title: "", message: "Пожалуйста, заполните все поля"))
            return true
        }
        return false
    }
    
    //MARK: Actions
    @objc func logoutTapped() {
        loginInputEnabled = true
        passwordInputEnabled = true
        signInButtonEnabled = true
        openCurrentView = true
    }
    
    @objc func signInTapped(_ sender: Any) {
        guard !checkEmptyFields() else { return }
        indicateSigningIn()
        signIn()
    }
    
    @objc func navigateToTSignUp() {
        openSignUpView = true
    }
    
    @objc func navigateToPasswordRecovery() {
        openPasswordRecoveryView = true
    }
}

//MARK: Networking
extension SignInViewModelOld {
    func signIn() {
        let signInRequest = SignInRequest(username: login, password: password)
        authService.sigIn(signInRequest: signInRequest) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                print("Success")
                storeTokensInfo(with: data)
                storeUserProfileInfo()
                signInActivityIndicatorAnimating = false
                openMainView = true
            case .failure(let error):
                indicateErrorSigningIn(error)
            }
        }
    }
    
    private func storeTokensInfo(with data: SignInResponse) {
        KeychainNeoDentist.setToken(value: data.access, key: KeychainConstants.accessToken)
        KeychainNeoDentist.setToken(value: data.refresh, key: KeychainConstants.refreshToken)
        UserDefaults.standard.setLoggedIn(value: true)
    }
    
    private func storeUserProfileInfo() {
        userNetworkService.getUserProfileLong { result in
            switch result {
            case .success(let userInfo):
                UserDefaults.standard.setValue(userInfo.firstName, forKey: UserDefaultsKeys.firstName)
                UserDefaults.standard.setValue(userInfo.lastName, forKey: UserDefaultsKeys.lastName)
                UserDefaults.standard.setValue(userInfo.username, forKey: UserDefaultsKeys.username)
                UserDefaults.standard.setValue(userInfo.email, forKey: UserDefaultsKeys.email)
                UserDefaults.standard.setValue(userInfo.phoneNumber, forKey: UserDefaultsKeys.phoneNumber)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
