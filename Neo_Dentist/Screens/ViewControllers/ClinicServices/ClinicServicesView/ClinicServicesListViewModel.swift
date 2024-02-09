//
//  ClinicServicesViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import Foundation

class ClinicServicesListViewModel {
    
    //MARK: Properties
    @Published private(set) var clinicServices: [SingleServiceResponse] = []
    
    private let servicesRepository: ServicesRepository
    private let goToSingleServiceNavigator: GoToSingleServiceNavigator
    
    //MARK: Methods
    init(servicesRepository: ServicesRepository, 
         goToSingleServiceNavigator: GoToSingleServiceNavigator) {
        self.servicesRepository = servicesRepository
        self.goToSingleServiceNavigator = goToSingleServiceNavigator
        
        getServices()
    }
    
    func navigateToSingleServiceView(with serviceID: Int) {
        goToSingleServiceNavigator.navigateToSingleService(serviceID: serviceID)
    }
    
}

//MARK: Networking
extension ClinicServicesListViewModel {
    func getServices() {
        servicesRepository
            .getServices(limit: 15)
            .done { response in
                self.clinicServices = response.services
            }.catch { error in
                print(error)
            }
    }
}

/*
 NotificationCenter.default.addObserver(self, selector: #selector(navigateToSelectDoctorView),
                                        name: NSNotification.Name ("openSelectDoctorViewFromServiceCollection"), object: nil)
 NotificationCenter.default.addObserver(self, selector: #selector(navigateToAppointmentView),
                                        name: NSNotification.Name ("openAppointmentView"), object: nil)
 
 @objc func navigateToSelectDoctorView(_ notification: NSNotification) {
     if let id = notification.userInfo?["serviceID"] as? Int {
         self.serviceID = id
         openSelectDoctorView = true
     }
 }
 
 @objc func navigateToAppointmentView() {
     openAppointmentView = true
 }
 
 /*
  service.getServices(limit: 15) {[weak self] result in
      guard let self else { return }
      switch result {
      case .success(let data):
          self.clinicServices = data.services
      case .failure(let failure):
          print(failure)
      }
  }
  */
 */
