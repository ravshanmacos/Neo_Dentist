//
//  OboardingViewState.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/02/24.
//

import Foundation

enum OnboardingViewState {
    case signIn
    case signUp
    case passwordReset
    case confirmByOtp
    case createNewPassword
    
    func hidesNavigationBar() -> Bool {
        switch self {
        case .passwordReset, .signIn, .createNewPassword:
            return true
        default:
            return false
        }
    }
}
