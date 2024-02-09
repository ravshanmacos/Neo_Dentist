//
//  NeoDentistServiceRepository.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 07/02/24.
//

import Foundation
import PromiseKit

class NeoDentistServiceRepository: ServicesRepository {
    
    //MARK: Properties
    private let remoteAPI: ServiceRemoteAPI
    
    init(remoteAPI: ServiceRemoteAPI) {
        self.remoteAPI = remoteAPI
    }
    
    func getServices(limit: Int) -> Promise<ServiceResponse> {
        remoteAPI.getServices(limit: limit)
    }
    
    func getService(with serviceId: Int) -> Promise<SingleServiceDescriptionResponse> {
        remoteAPI.getService(with: serviceId)
    }
}
