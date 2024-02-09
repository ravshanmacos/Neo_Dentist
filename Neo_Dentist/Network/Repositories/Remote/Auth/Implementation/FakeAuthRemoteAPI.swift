//
//  FakeAuthRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import PromiseKit

class FakeAuthRemoteAPI: AuthRemoteAPI {
    
    //MARK: Methods
    init(){}
    
    func signIn(username: String, password: String) -> Promise<UserSession> {
        guard username == "ravshan_winter" && password == "ravshan9805" else {
            return Promise(error: NeoDentistError.failedToSignIn)
        }
        return Promise<UserSession> { resolver in
            let dispatchItem = DispatchWorkItem {
                let profile = UserProfile(name: "Ravshanbek Tursunbaev",
                                          email: "ravshanbektursunbaev@yahoo.com",
                                          phoneNumber: "+998908399805",
                                          avatar: makeURL())
                let remoteUserSession = RemoteUserSession(token: "64652626")
                let userSession = UserSession(userProfile: profile, remoteSession: remoteUserSession)
                resolver.fulfill(userSession)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: dispatchItem)
        }
    }
    
    func signUp(account: NewAccount) -> Promise<UserSession> {
        let profile = UserProfile(name: account.fullname,
                                  email: account.email,
                                  phoneNumber: account.phoneNumber,
                                  avatar: makeURL())
        let remoteSession = RemoteUserSession(token: "64652626")
        let userSession = UserSession(userProfile: profile, remoteSession: remoteSession)
        return .value(userSession)
    }
}
