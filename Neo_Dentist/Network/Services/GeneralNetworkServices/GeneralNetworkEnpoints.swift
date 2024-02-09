//
//  GeneralNetworkEnpoints.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation
import Alamofire

enum GeneralNetworkEnpoints: RESTEnpoint {
    case getAdvertisement

    var method: Alamofire.HTTPMethod {
        switch self {
        case .getAdvertisement:
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
        case .getAdvertisement:
            return "/common/advertisement/"
        }
    }
}

