//
//  DoctorsNetworkEnpoints.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation
import Alamofire

enum DoctorsNetworkEnpoints: RESTEnpoint {
    case getDoctors(limit: Int)
    case getRecomendedDoctors
    case getDoctorDescription(id: Int)
    case likeDoctor(doctorID: Int, isFavorite: Bool)
    case likedDoctors(limit: Int, page: Int)
    case availableHours(doctorID: Int)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .likeDoctor:
            return .post
        default:
            return .get
        }
    }
    
    var encodableParameters: Encodable {
        switch self {
        case .likeDoctor(let doctorID, let isFavorite):
            let request = LikeDoctorRequest(doctorID: doctorID, isFavorite: isFavorite)
            return request
        default:
            return EmptyRequest()
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getDoctors(let limit):
            return ["limit": limit]
        case .likedDoctors(let limit, let page):
            return ["limit": limit, "page": page]
        default:
            return nil
        }
    }
    
    var encoder: Alamofire.JSONParameterEncoder {
        switch self {
        default:
            return JSONParameterEncoder.default
        }
    }
    
    var url: String? {
        switch self {
        case .getDoctors:
            return "/doctors/"
        case .likedDoctors:
            return "/doctors/favorite/"
        case .getRecomendedDoctors:
            return "/doctors/recommended/"
        case .getDoctorDescription(let id):
            return "/doctors/\(id)/"
        case .likeDoctor:
            return "/doctors/favorite/"
        case .availableHours(let doctorID):
            return "/doctors/\(doctorID)/hours/"
        }
    }
}

