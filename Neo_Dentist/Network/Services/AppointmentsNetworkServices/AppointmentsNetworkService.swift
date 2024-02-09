//
//  AppointmentsNetworkService.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/01/24.
//

import Foundation

protocol AppointmentsNetworkService {
    func getAppointments(status: String, callback: @escaping (Result<[AppointmentsResponse], Error>) -> Void)
    func createAppointment(appointmentRequest: MakeAppointmentRequest, callback: @escaping (Result<AppointmentsResponse, Error>) -> Void)
    func deleteAppointment(id: Int, callback: @escaping (Result<String, Error>) -> Void)
}

struct AppointmentsNetworkServiceImplementation: AppointmentsNetworkService {
    let apiManager: APIManager
    let mapper: JSONMapper
    
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func getAppointments(status: String, callback: @escaping (Result<[AppointmentsResponse], Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: AppointmentsNetworkEndpoints.getAppointments(status: status)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [AppointmentsResponse].self))
        }
    }
    
    func createAppointment(appointmentRequest: MakeAppointmentRequest, callback: @escaping (Result<AppointmentsResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AppointmentsNetworkEndpoints.createAppointment(appointmentRequest: appointmentRequest)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: AppointmentsResponse.self))
        }
    }
    
    func deleteAppointment(id: Int, callback: @escaping (Result<String, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: AppointmentsNetworkEndpoints.cancelAppointment(id: id)) { response in
            switch response {
            case .success(_):
                callback(Result.success("Successfully deleted"))
            case .failure(let deletionError):
                callback(Result.failure(deletionError))
            }
        }
    }
}
