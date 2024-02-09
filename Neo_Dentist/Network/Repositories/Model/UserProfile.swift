//
//  UserProfile.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

struct UserProfile: Equatable, Codable {
    let name: String
    let email: String
    let phoneNumber: String
    let avatar: URL
    
    init(name: String, email: String, phoneNumber: String, avatar: URL) {
        self.name = name
        self.email = email
        self.phoneNumber = phoneNumber
        self.avatar = avatar
    }
}
