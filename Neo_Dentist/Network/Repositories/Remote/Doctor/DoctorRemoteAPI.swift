//
//  DoctorRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 07/02/24.
//

import Foundation
import PromiseKit

protocol DoctorRemoteAPI {
    func getDoctors(limit: Int) -> Promise<DoctorsResponse>
    func getDoctor(with doctorId: Int) -> Promise<SingleDoctorDescriptionResponse>
    
    func getRecomendedDoctors() -> Promise<SingleDoctorResponse>
    func getDoctorAvailableHours(with doctorId: Int) -> Promise<[AvailableHoursResponse]>
    
    func getLikedDoctors(limit: Int, page: Int) -> Promise<[SingleDoctorResponse]>
    func likeDoctor(for doctorId: Int, isFavorite: Bool) -> Promise<SuccessResponse>
}
