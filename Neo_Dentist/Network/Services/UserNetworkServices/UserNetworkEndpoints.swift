//
//  UserNetworkEndpoints.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/01/24.
//

import Foundation
import Alamofire

enum UserNetworkEndpoints: RESTEnpoint {
    case getUserProfileShort
    case getUserPrifleLong
    case updateProfile(request: UpdateUserProfileRequest)
    case deleteProfile

    var method: Alamofire.HTTPMethod {
        switch self {
        case .deleteProfile:
            return .delete
        case .updateProfile:
            return .patch
        default:
            return .get
        }
    }
    
    var encodableParameters: Encodable {
        switch self {
        case .updateProfile(let request):
            return request
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
        case .getUserProfileShort, .getUserPrifleLong, .updateProfile, .deleteProfile:
            return "/users/profile/"
        }
    }
}
