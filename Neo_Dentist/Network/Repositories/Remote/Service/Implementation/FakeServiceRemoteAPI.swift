//
//  FakeServiceRemoteAPI.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 07/02/24.
//

import Foundation
import PromiseKit

class FakeServiceRemoteAPI: ServiceRemoteAPI {
    
    //MARK: Methods
    func getServices(limit: Int) -> Promise<ServiceResponse> {
        return Promise<ServiceResponse> { resolver in
            guard limit > 0 else { return resolver.reject(NeoDentistError.failedToGetServices)}
            let imageURLString = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/icon1_vfpgrj"
            let singleServiceResponses: [SingleServiceResponse] = Array(0...limit).map { index in
                let internetImage1 = InternetImage(id: 11 + index, imageString: imageURLString)
                return SingleServiceResponse(id: index + 1,
                                                            name: "Пломбирование зубов",
                                                            image: internetImage1)
            }
            
            let serviceResponse = ServiceResponse(totalCount: 15,
                                                  totalPages: 1,
                                                  services: singleServiceResponses)
            resolver.fulfill(serviceResponse)
        }
    }
    
    func getService(with serviceId: Int) -> Promise<SingleServiceDescriptionResponse> {
        return Promise<SingleServiceDescriptionResponse> { resolver in
            guard serviceId > 0 else { return resolver.reject(NeoDentistError.failedToGetService) }
            let specialization = Specialization(id: 1, name: "Ортодонт высшей категории")
            let workDays = ["Пн","Ср","Пт"]
            
            let imageURLString = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/photo_bkc94t"
            let imageURLString2 = "https://res.cloudinary.com/dqkyrxpjs/image/upload/v1/media/images/icon1_vfpgrj"
            
            let internetImage = InternetImage(id: 2, imageString: imageURLString)
            let internetImage2 = InternetImage(id: 12, imageString: imageURLString2)
            
            let singleDoctor = SingleDoctorResponse(id: 1, fullname: "Смирнова Анна Ивановна", specialization: specialization, workExperience: 6, rating: 4.9, workDays: workDays, startWorkTime: "08:00", endWorkTime: "15:00", image: internetImage, isFavorite: false)
            
            let SingleService = SingleServiceDescriptionResponse(id: 1, name: "Пломбирование зубов", description: "Пломбирование зубов - это одна из наиболее распространенных стоматологических процедур, которая выполняется для лечения зубов, пораженных кариесом или поврежденных другими факторами", recommendedDoctor: singleDoctor, minPrice: 2000, maxPrice: 3000, currency: "KGS", image: internetImage2)
            resolver.fulfill(SingleService)
        }
    }
}

