//
//  AuthRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation
import PromiseKit

protocol AuthRemoteAPI {
    func signIn(username: String, password: String) -> Promise<UserSession>
    func signUp(account: NewAccount) -> Promise<UserSession>
}
