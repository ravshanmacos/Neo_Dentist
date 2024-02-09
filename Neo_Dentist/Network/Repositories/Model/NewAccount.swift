//
//  NewAccount.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class NewAccount: Codable {
    
    //MARK: Properties
    let fullname: String
    let nickname: String
    let email: String
    let phoneNumber: String
    let password: Secret
    
    //MARK: Methods
    init(fullname: String,
         nickname: String,
         email: String,
         phoneNumber: String,
         password: Secret) {
        self.fullname = fullname
        self.nickname = nickname
        self.email = email
        self.phoneNumber = phoneNumber
        self.password = password
    }
}
