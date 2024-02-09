//
//  UserNetworkService.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 08/01/24.
//

import Foundation

protocol UserNetworkService {
    func getUserProfileShort(callback: @escaping (Result<UserProfileShortResponse, Error>) -> Void)
    func getUserProfileLong(callback: @escaping (Result<UserProfileLongResponse, Error>) -> Void)
    func updateUserProfile(request: UpdateUserProfileRequest, callback: @escaping (Result<UserProfileUpdateResponse, Error>) -> Void)
    func deleteUserProfile(callback: @escaping (Result<String, Error>) -> Void)
}

struct UserNetworkServiceImplementation: UserNetworkService {
    let apiManager: APIManager
    let mapper: JSONMapper
    
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func getUserProfileShort(callback: @escaping (Result<UserProfileShortResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: UserNetworkEndpoints.getUserProfileShort) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: UserProfileShortResponse.self))
        }
    }
    
    func getUserProfileLong(callback: @escaping (Result<UserProfileLongResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: UserNetworkEndpoints.getUserPrifleLong) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: UserProfileLongResponse.self))
        }
    }
    
    func updateUserProfile(request: UpdateUserProfileRequest, callback: @escaping (Result<UserProfileUpdateResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: UserNetworkEndpoints.updateProfile(request: request)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: UserProfileUpdateResponse.self))
        }
    }
    
    func deleteUserProfile(callback: @escaping (Result<String, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: UserNetworkEndpoints.deleteProfile) { response in
            switch response {
            case .success(_):
                callback(Result.success("Successfully deleted"))
            case .failure(let deletionError):
                callback(Result.failure(deletionError))
            }
        }
    }
}
