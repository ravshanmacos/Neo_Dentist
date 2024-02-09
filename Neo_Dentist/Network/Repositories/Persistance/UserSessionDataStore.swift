//
//  UserSessionDataStore.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import PromiseKit

protocol UserSessionDataStore {
    func readUserSession() -> Promise<UserSession?>
    func save(userSession: UserSession) -> Promise<(UserSession)>
    func delete(userSession: UserSession) -> Promise<(UserSession)>
}
