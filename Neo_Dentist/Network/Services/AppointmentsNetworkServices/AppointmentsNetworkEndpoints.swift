//
//  AppointmentsNetworkEndpoints.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/01/24.
//

import Foundation
import Alamofire

enum AppointmentsNetworkEndpoints: RESTEnpoint {
    case getAppointments(status: String)
    case createAppointment(appointmentRequest: MakeAppointmentRequest)
    case cancelAppointment(id: Int)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .createAppointment:
            return .post
        case .cancelAppointment:
            return .delete
        default:
            return .get
        }
    }
    
    var encodableParameters: Encodable {
        switch self {
        case .createAppointment(let appointmentRequest):
            return appointmentRequest
        default:
            return EmptyRequest()
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        case .getAppointments(let status):
            return ["status": status]
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
        case .getAppointments, .createAppointment:
            return "/appointments/"
        case .cancelAppointment(let id):
            return "/appointments/\(id)/"
        }
    }
}
