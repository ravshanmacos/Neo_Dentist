//
//  MainViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/02/24.
//

import Foundation

class MainManagerViewModel: SignedInResponder, NotSignedInResponder {
    
    //MARK: Properties
    @Published private(set) var view: MainManagerViewState = .launching
    
    func signedIn(to userSession: UserSession) {
        view = .signedIn(userSession: userSession)
    }
    
    func notSignedIn() {
        view = .onboarding
    }
}
