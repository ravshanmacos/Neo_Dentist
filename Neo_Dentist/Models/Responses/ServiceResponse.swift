//
//  ServiceResponse.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

struct ServiceResponse: Decodable {
    let totalCount: Int
    let totalPages: Int
    let services: [SingleServiceResponse]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case totalPages = "total_pages"
        case services = "list"
    }
}

struct SingleServiceResponse: Decodable {
    let id: Int
    let name: String
    let image: InternetImage
    
    func getImageURL() -> URL? {
        return URL(string: image.imageString)
    }
}

struct SingleServiceDescriptionResponse: Decodable {
    let id: Int
    let name: String
    let description: String
    let recommendedDoctor: SingleDoctorResponse
    let minPrice: Int
    let maxPrice: Int
    let currency: String
    let image: InternetImage
    
    enum CodingKeys: String, CodingKey {
        case id, name, description
        case recommendedDoctor = "recommended_doctor"
        case minPrice = "min_price"
        case maxPrice = "max_price"
        case currency, image
    }
}
