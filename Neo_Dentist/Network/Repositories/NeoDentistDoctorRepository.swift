//
//  NeoDentistDoctorRepository.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 07/02/24.
//

import Foundation
import PromiseKit

class NeoDentistDoctorRepository: DoctorRepository {
    //MARK: Properties
    private let remoteAPI: DoctorRemoteAPI
    
    init(remoteAPI: DoctorRemoteAPI) {
        self.remoteAPI = remoteAPI
    }
    
    //MARK: Methods
    
    func getDoctors(limit: Int) -> Promise<DoctorsResponse> {
        remoteAPI.getDoctors(limit: limit)
    }
    
    func getDoctor(with doctorId: Int) -> Promise<SingleDoctorDescriptionResponse> {
        remoteAPI.getDoctor(with: doctorId)
    }
    
    func getRecomendedDoctors() -> Promise<SingleDoctorResponse> {
        remoteAPI.getRecomendedDoctors()
    }
    
    func getDoctorAvailableHours(with doctorId: Int) -> Promise<[AvailableHoursResponse]> {
        remoteAPI.getDoctorAvailableHours(with: doctorId)
    }
    
    func getLikedDoctors(limit: Int, page: Int) -> Promise<[SingleDoctorResponse]> {
        remoteAPI.getLikedDoctors(limit: limit, page: page)
    }
    
    func likeDoctor(for doctorId: Int, isFavorite: Bool) -> Promise<SuccessResponse> {
        remoteAPI.likeDoctor(for: doctorId, isFavorite: isFavorite)
    }
}
