//
//  MainRequests.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

struct EmptyRequest: Encodable {}
struct LikeDoctorRequest: Encodable {
    let doctorID: Int
    let isFavorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case doctorID = "doctor"
        case isFavorite = "is_favorite"
    }
}

struct MakeAppointmentRequest: Encodable {
    var doctorID: Int
    var serviceID: Int
    var appointmentTime: String
    var patientFirstName: String
    var patientLastName: String
    var patientPhoneNumber: String
    
    enum CodingKeys: String, CodingKey {
    case doctorID = "doctor"
    case serviceID = "service"
    case appointmentTime = "appointment_time"
    case patientFirstName = "patient_first_name"
    case patientLastName = "patient_last_name"
    case patientPhoneNumber = "patient_phone_number"
    }
}

extension MakeAppointmentRequest {
    mutating func emptyAppointmentRequest() {
        self.doctorID = 0
        self.serviceID = 0
        self.appointmentTime = ""
        self.patientFirstName = ""
        self.patientLastName = ""
        self.patientPhoneNumber = ""
    }
}

struct UpdateUserProfileRequest: Encodable {
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

