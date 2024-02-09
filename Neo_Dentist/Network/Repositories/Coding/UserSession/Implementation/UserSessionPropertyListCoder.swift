//
//  UserSessionPropertyListCoder.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class UserSessionPropertyListCoder: UserSessionCoding {
    
    init() {}
    
    func encode(userSession: UserSession) -> Data {
        let encoder = PropertyListEncoder()
        return try! encoder.encode(userSession)
    }
    
    func decode(data: Data) -> UserSession {
        let decoder = PropertyListDecoder()
        return try! decoder.decode(UserSession.self, from: data)
    }
}
