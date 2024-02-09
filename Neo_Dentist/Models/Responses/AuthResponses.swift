//
//  AuthResponses.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 22/12/23.
//

import Foundation

struct SignUpResponse: Decodable {
    let message: String
    let userID: Int
    let isVerified: Bool
    
    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
        case isVerified = "is_verified"
    }
}

struct SignInResponse: Decodable {
    let refresh: String
    let access: String
}

struct SendVerificationCodeResponse: Decodable {
    let message: String
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case message
        case userID = "user_id"
    }
}

struct CodeVerificationReponse: Decodable {
    let message: String
    let refresh: String
    let access: String
}
