//
//  ServiceRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 07/02/24.
//

import Foundation
import PromiseKit

protocol ServiceRemoteAPI {
    func getServices(limit: Int) -> Promise<ServiceResponse>
    func getService(with serviceId: Int) -> Promise<SingleServiceDescriptionResponse>
}
