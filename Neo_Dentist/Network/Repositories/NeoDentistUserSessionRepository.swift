//
//  NeoDentistUserSessionRepository.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import PromiseKit

let GlobalUserSessionRepository: UserSessionRepository = {
    
    let userSessionCoder = UserSessionPropertyListCoder()
    let userSessionDataStore = KeychainUserSessionDataStore(userSessionCoder: userSessionCoder)
    let authRemoteAPI = FakeAuthRemoteAPI()
    return NeoDentistUserSessionRepository(dataStore: userSessionDataStore, remoteAPI: authRemoteAPI)
}()


class NeoDentistUserSessionRepository: UserSessionRepository {
    
    //MARK: Properties
    let dataStore: UserSessionDataStore
    let remoteAPI: AuthRemoteAPI
    
    //MARK: Methods
    init(dataStore: UserSessionDataStore, remoteAPI: AuthRemoteAPI) {
        self.dataStore = dataStore
        self.remoteAPI = remoteAPI
    }
    
    func readUserSession() -> Promise<UserSession?> {
        dataStore.readUserSession()
    }
    
    func signUp(newAccount: NewAccount) -> Promise<UserSession> {
        remoteAPI
            .signUp(account: newAccount)
            .then(dataStore.save(userSession:))
    }
    
    func signIn(email: String, password: String) -> Promise<UserSession> {
        remoteAPI
            .signIn(username: email, password: password)
            .then(dataStore.save(userSession:))
    }
    
    func signOut(userSession: UserSession) -> Promise<UserSession> {
        dataStore.delete(userSession: userSession)
    }
}
