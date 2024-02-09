//
//  ClinicNetworkService.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

protocol ClinicNetworkService {
    func getServices(limit: Int, callback: @escaping (Result<ServiceResponse, Error>) -> Void)
    func getService(serviceID: Int, callback: @escaping (Result<SingleServiceDescriptionResponse, Error>) -> Void)
}

struct ClinicNetworkServiceImplementation: ClinicNetworkService {
    let apiManager: APIManager
    let mapper: JSONMapper
    
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func getServices(limit: Int, callback: @escaping (Result<ServiceResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: ClinicNetworkEndpoints.getServices(limit: limit)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: ServiceResponse.self))
        }
    }
    
    func getService(serviceID: Int, callback: @escaping (Result<SingleServiceDescriptionResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: ClinicNetworkEndpoints.getService(serviceID: serviceID)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SingleServiceDescriptionResponse.self))
        }
    }
}
