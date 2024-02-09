//
//  InfoAboutServiceViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import Foundation

class ClinicServiceViewModel {
    
    @Published private(set) var dismissPandModal = false
    @Published private(set) var serviceInfo: SingleServiceDescriptionResponse?
    
    private let servicesRepository: ServicesRepository
    private let goToDoctorsListNavigator: GoToDoctorsListNavigator
    
    init( serviceID: Int, 
          servicesRepository: ServicesRepository,
          goToDoctorsListNavigator: GoToDoctorsListNavigator) {
        self.servicesRepository = servicesRepository
        self.goToDoctorsListNavigator = goToDoctorsListNavigator
        getServiceInfo()
    }
    
    @objc func makeAppointmentButtonTapped() {
        dismissPandModal = true
        goToDoctorsListNavigator.navigateToDoctorsList()
    }
}

extension ClinicServiceViewModel {
    func getServiceInfo() {
        servicesRepository
            .getService(with: 2)
            .done { response in
                self.serviceInfo = response
            }.catch { error in
                print(error)
            }
       /*
        clinicNetworkService.getService(serviceID: serviceID) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.serviceInfo = data
            case .failure(let failure):
                print(failure)
            }
        }
        */
    }
}
