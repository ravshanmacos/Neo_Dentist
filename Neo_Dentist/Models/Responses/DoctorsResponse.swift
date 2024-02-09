//
//  DoctorsResponse.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

struct DoctorsResponse: Decodable {
    let totalCount: Int
    let totalPages: Int
    let doctors: [SingleDoctorResponse]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case totalPages = "total_pages"
        case doctors = "list"
    }
}

struct SingleDoctorResponse: Decodable {
    let id: Int
    let fullname: String
    let specialization: Specialization
    let workExperience: Int
    let rating: Float?
    let workDays: [String]
    let startWorkTime: String
    let endWorkTime: String
    let image: InternetImage
    let isFavorite: Bool
    
    func getImageURL() -> URL? {
        return URL(string: image.imageString)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullname = "full_name"
        case specialization = "specialization"
        case workExperience = "work_experience"
        case rating = "rating"
        case workDays = "work_days"
        case startWorkTime = "start_work_time"
        case endWorkTime = "end_work_time"
        case image = "image"
        case isFavorite = "is_favorite"
    }
}

struct SingleDoctorDescriptionResponse: Decodable {
    let id: Int
    let fullname: String
    let description: String
    let specialization: Specialization
    let workExperience: Int
    let rating: Float?
    let workDays: [String]
    let startWorkTime: String
    let endWorkTime: String
    let image: InternetImage
    let isFavorite: Bool
    
    func getImageURL() -> URL? {
        return URL(string: image.imageString)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullname = "full_name"
        case description = "description"
        case specialization = "specialization"
        case workExperience = "work_experience"
        case rating = "rating"
        case workDays = "work_days"
        case startWorkTime = "start_work_time"
        case endWorkTime = "end_work_time"
        case image = "image"
        case isFavorite = "is_favorite"
    }
}

struct Specialization: Decodable {
    let id: Int
    let name: String
}

struct AvailableHoursResponse: Decodable {
    let timeSlot: String
    
    enum CodingKeys: String, CodingKey {
        case timeSlot = "time_slot"
    }
}
