//
//  InfoAboutDoctorViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 29/12/23.
//

import Foundation

class DoctorViewModel {
    
    //MARK: Properties
    @Published private(set) var doctorDescription: SingleDoctorDescriptionResponse?
    
    private let doctorRepository: DoctorRepository
    private let goToSelectDateNavigator: GoToSelectDateNavigator
    let doctorId: Int
    
    //MARK: Methods
    init(doctorId: Int,
         doctorRepository: DoctorRepository,
         goToSelectDateNavigator: GoToSelectDateNavigator) {
        self.doctorId = doctorId
        self.doctorRepository = doctorRepository
        self.goToSelectDateNavigator = goToSelectDateNavigator
    }
    
    @objc func nextButtonTapped() {
        goToSelectDateNavigator.navigateToSelectDate()
    }
    
    func likeDoctor(isFavorite: Bool) {
        /*
         service.likeDoctor(doctorID: doctorId, isFavorite: isFavorite) { result in
             switch result {
             case .success(let data):
                 print(data.message)
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
}

//MARK: Networking
extension DoctorViewModel {
    func getDoctorDescription() {
        doctorRepository.getDoctor(with: 2)
            .done { response in
                self.doctorDescription = response
            }.catch { error in
                print(error)
            }
       /*
        service.getDoctorDescription(id: doctorId) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                doctorDescription = data
            case .failure(let failure):
                print(failure)
            }
        }
        */
    }
}


