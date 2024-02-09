//
//  FakeDoctorRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 07/02/24.
//

import Foundation
import PromiseKit

class FakeDoctorRemoteAPI: DoctorRemoteAPI {
    
    //MARK: Methods
    func getDoctors(limit: Int) -> Promise<DoctorsResponse> {
        return Promise<DoctorsResponse> { resolver in
            guard limit > 0 else { return resolver.reject(NeoDentistError.failedToGetDoctors)}
            let imageURLString = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/doc2_cxg9gi"
            
            let internetImage = InternetImage(id: 2, imageString: imageURLString)
            
            let workDays = ["Пн", "Ср", "Пт"]
            let specialization = Specialization(id: 2, name: "Детский стоматолог средней категории")
            let singleDoctorResponses: [SingleDoctorResponse] = Array(0...limit).map { index in
                let singleDoctorResponse = SingleDoctorResponse(id: index+1, fullname: "Смирнова Анна Ивановна", specialization: specialization, workExperience: 6, rating: 4.9, workDays: workDays, startWorkTime: "08:00", endWorkTime: "17:00", image: internetImage, isFavorite: false)
                return singleDoctorResponse
            }
            
            let serviceResponse = DoctorsResponse(totalCount: 10,
                                                  totalPages: 1,
                                                  doctors: singleDoctorResponses)
            resolver.fulfill(serviceResponse)
        }
    }
    
    func getDoctor(with doctorId: Int) -> Promise<SingleDoctorDescriptionResponse> {
        return Promise<SingleDoctorDescriptionResponse> { resolver in
            guard doctorId > 0 else { return resolver.reject(NeoDentistError.failedToGetDoctor) }
            let specialization = Specialization(id: 2, name: "Детский стоматолог средней категории")
            let workDays = ["Вт","Чт"]
            
            let imageURLString = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/doc2_cxg9gi"
            let internetImage = InternetImage(id: 3, imageString: imageURLString)
            
            let singleDoctor = SingleDoctorDescriptionResponse(id: 2, fullname: "Бектенова Сезим Асановна", description: "Оценка и лечение зубов детей всех возрастов, начиная с ранних лет.\r\nПрофилактика кариеса и других зубных заболеваний с использованием фтора и герметизации.\r\nВыявление и лечение зубных проблем, таких как кариес, молочный зубной прикус и другие аномалии развития.\r\nПроведение профессиональной чистки и удаление зубного налета у детей.", specialization: specialization, workExperience: 5, rating: 5, workDays: workDays, startWorkTime: "08:00", endWorkTime: "17:00", image: internetImage, isFavorite: false)
            resolver.fulfill(singleDoctor)
        }
    }
    
    func getRecomendedDoctors() -> Promise<SingleDoctorResponse> {
        return Promise<SingleDoctorResponse> { resolver in
            let specialization = Specialization(id: 2, name: "Детский стоматолог средней категории")
            let workDays = ["Вт","Чт"]
            
            let imageURLString = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/doc2_cxg9gi"
            let internetImage = InternetImage(id: 3, imageString: imageURLString)
            
            let singleDoctor = SingleDoctorResponse (id: 2, fullname: "Бектенова Сезим Асановна", specialization: specialization, workExperience: 5, rating: 5, workDays: workDays, startWorkTime: "08:00", endWorkTime: "17:00", image: internetImage, isFavorite: false)
            resolver.fulfill(singleDoctor)
        }
    }
    
    func getDoctorAvailableHours(with doctorId: Int) -> Promise<[AvailableHoursResponse]> {
        return Promise<[AvailableHoursResponse]> { resolver in
            let slots: [AvailableHoursResponse] = Array(8...15).map { index in
                if index > 9 {
                   return AvailableHoursResponse(timeSlot: "\(index):00")
                } else {
                    return AvailableHoursResponse(timeSlot: "0\(index):00")
                }
            }
            resolver.fulfill(slots)
        }
    }
    
    func getLikedDoctors(limit: Int, page: Int) -> Promise<[SingleDoctorResponse]> {
        return Promise<[SingleDoctorResponse]> { resolver in
            guard limit > 0 else { return resolver.reject(NeoDentistError.failedToGetDoctors)}
            let imageURLString = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/doc2_cxg9gi"
            
            let internetImage = InternetImage(id: 2, imageString: imageURLString)
            
            let workDays = ["Пн", "Ср", "Пт"]
            let specialization = Specialization(id: 2, name: "Детский стоматолог средней категории")
            let singleDoctorResponses: [SingleDoctorResponse] = Array(0...limit).map { index in
                let singleDoctorResponse = SingleDoctorResponse(id: index+1, fullname: "Смирнова Анна Ивановна", specialization: specialization, workExperience: 6, rating: 4.9, workDays: workDays, startWorkTime: "08:00", endWorkTime: "17:00", image: internetImage, isFavorite: true)
                return singleDoctorResponse
            }
            resolver.fulfill(singleDoctorResponses)
        }
    }
    
    func likeDoctor(for doctorId: Int, isFavorite: Bool) -> Promise<SuccessResponse> {
        return Promise<SuccessResponse> { resolver in
            resolver.fulfill(SuccessResponse(message: "SuccessFully Liked"))
        }
    }
}
