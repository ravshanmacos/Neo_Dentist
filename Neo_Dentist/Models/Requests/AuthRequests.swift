//
//  AuthRequests.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 22/12/23.
//

import Foundation

struct SignUpRequest: Encodable {
    let firstname: String
    let lastname: String
    let username: String
    let email: String
    let phoneNumber: String
    let password: String
    let confirmPassword: String
    
    enum CodingKeys: String, CodingKey {
        case firstname = "first_name"
        case lastname = "last_name"
        case username, email
        case phoneNumber = "phone_number"
        case password
        case confirmPassword = "confirm_password"
    }
}

struct SignInRequest: Encodable {
    let username: String
    let password: String
}

struct SendVerificationCodeRequest: Encodable {
    let username: String
    let email: String
}

struct VerifyPaswordResetCode: Encodable {
    let code: Int
}

struct PasswordChangeRequest: Encodable {
    let password: String
    let confirmPassword: String
    
    enum CodingKeys: String, CodingKey {
        case password = "password"
        case confirmPassword = "confirm_password"
    }
}
