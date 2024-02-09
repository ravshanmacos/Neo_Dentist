//
//  UserSession.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

struct UserSession: Codable {
    //MARK: Properties
    let userProfile: UserProfile
    let remoteSession: RemoteUserSession
    
    //MARK: Methods
    init(userProfile: UserProfile, remoteSession: RemoteUserSession) {
        self.userProfile = userProfile
        self.remoteSession = remoteSession
    }
}

extension UserSession: Equatable {
    static func ==(lhs: UserSession, rhs: UserSession) -> Bool {
        return lhs.userProfile == rhs.userProfile && lhs.remoteSession == rhs.remoteSession
    }
}
