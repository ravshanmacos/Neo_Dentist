//
//  AuthFactories.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 23/12/23.
//

import Foundation

protocol SignInFactory {
    func makeTabBarController() -> TabbarController
    func makeSignUpViewController() -> SignUpViewController
    func makeVerifyUserViewController() -> PasswordResetViewController
}

protocol VerifyUserFactory {
    func makeConfirmByMessageViewController(byEmail: Bool, request: SendVerificationCodeRequest) -> ConfirmByMessageViewController
}

protocol ConfirmByMessageFactory {
    func makeTabBarController() -> TabbarController
    func makeCreateNewPasswordViewController() -> CreateNewPasswordViewController
}

protocol CreateNewPasswordFactory {
    func makeTabBarController() -> TabbarController
}
