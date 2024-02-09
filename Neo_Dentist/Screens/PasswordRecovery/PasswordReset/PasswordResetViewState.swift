//
//  PasswordResetViewState.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/02/24.
//

import Foundation

enum PasswordResetViewState {
    case verifyByOtp
    case createPassword
}

extension PasswordResetViewState {
    func hidesNavigationBar() -> Bool {
        switch self {
        case .verifyByOtp:
            return false
        case .createPassword:
            return true
        }
    }
}
