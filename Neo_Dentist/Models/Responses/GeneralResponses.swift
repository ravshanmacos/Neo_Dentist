//
//  GeneralResponses.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

struct EmptyResponse: Decodable {}

struct SuccessResponse: Decodable {
    let message: String
}

struct AdvertisementResponse: Decodable {
    let id: Int
    let title: String
    let text: String
    let image: InternetImage
    let author: String
    
    func getImageURL() -> URL? {
        return URL(string: image.imageString)
    }
}

struct InternetImage: Decodable {
    let id: Int
    let imageString: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageString = "file"
    }
}

