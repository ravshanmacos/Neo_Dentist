//
//  MainView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/02/24.
//

import Foundation

enum MainManagerViewState {
    case launching
    case onboarding
    case signedIn(userSession: UserSession)
}

extension MainManagerViewState: Equatable {
    static func ==(lhs: MainManagerViewState, rhs: MainManagerViewState) -> Bool {
        switch (lhs, rhs) {
        case (.launching, .launching):
            return true
        case (.onboarding, .onboarding):
            return true
        case let (.signedIn(l), .signedIn(r)):
            return l == r
        case (.launching, _),
            (.onboarding, _),
            (.signedIn, _):
            return false
        }
    }
}
