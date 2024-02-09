//
//  DoctorsNetworkService.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

protocol DoctorsNetworkService {
    func likeDoctor(doctorID: Int, isFavorite: Bool, callback: @escaping (Result<SuccessResponse, Error>) -> Void)
    
    func getDoctors(limit: Int, callback: @escaping (Result<DoctorsResponse, Error>) -> Void)
    func getLikedDoctors(limit: Int, page: Int, callback: @escaping (Result<[SingleDoctorResponse], Error>) -> Void)
    func getRecomendedDoctors(callback: @escaping (Result<SingleDoctorResponse, Error>) -> Void)
    
    func getDoctorDescription(id: Int, callback: @escaping (Result<SingleDoctorDescriptionResponse, Error>) -> Void)
    func getDoctorAvailableHours(doctorID: Int, callback: @escaping (Result<[AvailableHoursResponse], Error>) -> Void)
}

struct DoctorsNetworkServiceImplementation: DoctorsNetworkService {
    let apiManager: APIManager
    let mapper: JSONMapper
    
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func likeDoctor(doctorID: Int, isFavorite: Bool, callback: @escaping (Result<SuccessResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: DoctorsNetworkEnpoints.likeDoctor(doctorID: doctorID, isFavorite: isFavorite)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SuccessResponse.self))
        }
    }
    
    func getLikedDoctors(limit: Int, page: Int, callback: @escaping (Result<[SingleDoctorResponse], Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: DoctorsNetworkEnpoints.likedDoctors(limit: limit, page: page)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [SingleDoctorResponse].self))
        }
    }
    
    func getRecomendedDoctors(callback: @escaping (Result<SingleDoctorResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: DoctorsNetworkEnpoints.getRecomendedDoctors) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SingleDoctorResponse.self))
        }
    }
    
    func getDoctors(limit: Int, callback: @escaping (Result<DoctorsResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: DoctorsNetworkEnpoints.getDoctors(limit: limit)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: DoctorsResponse.self))
        }
    }
    
    func getDoctorDescription(id: Int, callback: @escaping (Result<SingleDoctorDescriptionResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: DoctorsNetworkEnpoints.getDoctorDescription(id: id)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SingleDoctorDescriptionResponse.self))
        }
    }
    
    func getDoctorAvailableHours(doctorID: Int, callback: @escaping (Result<[AvailableHoursResponse], Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: DoctorsNetworkEnpoints.availableHours(doctorID: doctorID)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: [AvailableHoursResponse].self))
        }
    }
}
