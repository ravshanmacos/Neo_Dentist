//
//  AppointmentsResponse.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/01/24.
//

import Foundation

struct AppointmentsResponse: Decodable {
    let id: Int
    let doctor: Doctor
    let service: Service
    let appointmentTime: String
    let patientFirstName: String
    let patientLastName: String
    let patientPhoneNumber: String
    let address: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case id, doctor, service
        case appointmentTime = "appointment_time"
        case patientFirstName = "patient_first_name"
        case patientLastName = "patient_last_name"
        case patientPhoneNumber = "patient_phone_number"
        case address, status
        
    }
}

struct Doctor: Decodable {
    let id: Int
    let fullName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
    }
}

struct Service: Decodable {
    let id: Int
    let name: String
}
