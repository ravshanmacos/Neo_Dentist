//
//  GeneralNetworkService.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import Foundation

protocol GeneralNetworkService {
    func getAdvertisement(callback: @escaping (Result<AdvertisementResponse, Error>) -> Void)
}

struct GeneralNetworkServiceImplementation: GeneralNetworkService {
    let apiManager: APIManager
    let mapper: JSONMapper
    
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func getAdvertisement(callback: @escaping (Result<AdvertisementResponse, Error>) -> Void) {
        apiManager.request(withEncodable: false, endpoint: GeneralNetworkEnpoints.getAdvertisement) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: AdvertisementResponse.self))
        }
    }
}
