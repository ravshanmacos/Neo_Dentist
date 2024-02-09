//
//  KeychainUserSessionDataStore.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import PromiseKit

class KeychainUserSessionDataStore: UserSessionDataStore {
    
    //MARK: Properties
    let userSessionCoder: UserSessionCoding
    
    init(userSessionCoder: UserSessionCoding) {
        self.userSessionCoder = userSessionCoder
    }
    
    //MARK: Methods
    func readUserSession() -> Promise<UserSession?> {
        return Promise<UserSession?> { resolver in
            DispatchQueue.global().async {
                self.readUserSessionSync(resolver)
            }
        }
    }
    
    func save(userSession: UserSession) -> Promise<(UserSession)> {
        let data = userSessionCoder.encode(userSession: userSession)
        let item = KeychainItemWithData(data: data)
        return self.readUserSession()
            .map { userSessionFromKeychain -> UserSession in
                if userSessionFromKeychain == nil {
                    try Keychain.save(item: item)
                } else {
                    try Keychain.update(item: item)
                }
                return userSession
            }
    }
    
    func delete(userSession: UserSession) -> Promise<(UserSession)> {
        return Promise<UserSession> { resolver in
            DispatchQueue.global().async {
                self.deleteSync(userSession: userSession, resolver)
            }
        }
    }
    
    
}

extension KeychainUserSessionDataStore {
    func readUserSessionSync(_ resolver: Resolver<UserSession?>) {
        do {
            let query = KeychainItemQuery()
            if let data = try Keychain.findItem(query: query) {
                let userSession = self.userSessionCoder.decode(data: data)
                resolver.fulfill(userSession)
            } else {
                resolver.fulfill(nil)
            }
        } catch let error {
            resolver.reject(error)
        }
    }
    
    func deleteSync(userSession: UserSession, _ resolver: Resolver<UserSession>) {
        do {
            let item = KeychainItem()
            try Keychain.delete(item: item)
            resolver.fulfill(userSession)
        } catch let error {
            resolver.reject(error)
        }
    }
}

enum KeychainUserSessionDataStoreError: Error {

  case typeCast
  case unknown
}
