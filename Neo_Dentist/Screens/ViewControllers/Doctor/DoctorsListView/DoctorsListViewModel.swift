//
//  SelectDoctorViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import Foundation
import Combine

class DoctorsListViewModel {
    
    //MARK: Properties
    @Published private(set) var openFilterDoctorView = false
    @Published private(set) var doctorsData: [SingleDoctorResponse] = []
    
    private var originalData: [SingleDoctorResponse] = [] {
        didSet {
            doctorsData = originalData
        }
    }
    private let doctorRepository: DoctorRepository
    private let goToSingleDoctorNavigator: GoToSingleDoctorNavigator
    
    var doctorID: Int?
    var selectedDoctor: Int = 0
    
    //MARK: Methods
    init(doctorRepository: DoctorRepository,
         goToSingleDoctorNavigator: GoToSingleDoctorNavigator) {
        self.doctorRepository = doctorRepository
        self.goToSingleDoctorNavigator = goToSingleDoctorNavigator
    }
    
    func selectedDoctor( with doctorID: Int) {
        goToSingleDoctorNavigator.navigateToSingleDoctor(doctorID: doctorID)
    }
    
    @objc func filterButtonTapped() {
        openFilterDoctorView = true
    }
    
    func searchDoctor(with text: String?) {
        guard let text else { return }
        doctorsData = []
        originalData.forEach { doctor in
            if doctor.fullname.contains(text) {
                 doctorsData.append(doctor)
            }
        }
    }
}

//MARK: Networking
extension DoctorsListViewModel {
    func getDoctors() {
        doctorRepository
            .getDoctors(limit: 15)
            .done { response in
                self.originalData = response.doctors
            }.catch { error in
                print(error)
            }
    }
}

/*
 NotificationCenter.default.addObserver(self, selector: #selector(updateSpecializationOptions), name: NSNotification.Name(rawValue: "UpdateSpecialization"), object: nil)
 
 NotificationCenter.default.addObserver(self, selector: #selector(updateDoctors), name: NSNotification.Name(rawValue: "UpdateDoctors"), object: nil)
 */

/*
 @objc func updateSpecializationOptions(_ notification: NSNotification) {
     
     if let optionsData = notification.userInfo?["optionsData"] as? [SpecializationModel], !optionsData.isEmpty {
         doctorsData = originalData
         doctorsData = doctorsData.filter { doctor in
             var result = false
             for option in optionsData {
                 if doctor.specialization.id == option.id {
                     result = true
                 }
             }
             return result
         }
     } else {
         doctorsData = originalData
     }
 }
 */

/*
 @objc func updateDoctors(_ notification: NSNotification) {
     if let optionsData = notification.userInfo?["optionsData"] as? [SpecializationModel], !optionsData.isEmpty {
         doctorsData = originalData
         doctorsData = doctorsData.filter { doctor in
             var result = false
             for option in optionsData {
                 if doctor.specialization.id == option.id {
                     result = true
                 }
             }
             return result
         }
     } else {
         doctorsData = originalData
     }
 }
 */

/*
 service.getDoctors(limit: 15) {[weak self] result in
     guard let self else { return }
     switch result {
     case .success(let data):
         originalData = data.doctors
     case .failure(let failure):
         print(failure)
     }
 }
 */
