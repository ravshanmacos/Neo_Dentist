//
//  RemoteUserSession.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

typealias AuthToken = String

struct RemoteUserSession: Codable {
    //MARK: Properties
    let token: AuthToken
    
    //MARK: Methods
    init(token: AuthToken) {
        self.token = token
    }
}

extension RemoteUserSession: Equatable {
    static func ==(lhs: RemoteUserSession, rhs: RemoteUserSession) -> Bool {
        return lhs.token == rhs.token
    }
}
