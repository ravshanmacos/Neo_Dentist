//
//  UserResponse.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/01/24.
//

import Foundation

struct UserProfileShortResponse: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
    }
}

struct UserProfileUpdateResponse: Decodable {
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case email = "email"
        case phoneNumber = "phone_number"
    }
}

struct UserProfileLongResponse: Decodable {
    let id: Int
    let email: String
    let username: String
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let appointments: [AppointmentsResponse]
    
    enum CodingKeys: String, CodingKey {
        case id, email, username
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
        case appointments
    }
}
