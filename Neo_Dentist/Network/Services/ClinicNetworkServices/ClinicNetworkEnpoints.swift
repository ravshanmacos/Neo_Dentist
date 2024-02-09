//
//  ClinicNetworkEndpoints.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation
import Alamofire

enum ClinicNetworkEndpoints: RESTEnpoint {
    case getServices(limit: Int)
    case getService(serviceID: Int)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getServices, .getService:
            return .get
        }
    }
    
    var encodableParameters: Encodable {
        switch self {
        default:
            return EmptyRequest()
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getServices(let limit):
            return ["limit": limit]
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
        case .getServices:
            return "/services/"
        case .getService(let serviceID):
            return "/services/\(serviceID)/"
        }
    }
}
