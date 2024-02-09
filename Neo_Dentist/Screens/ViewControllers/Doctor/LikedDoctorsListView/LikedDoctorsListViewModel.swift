//
//  LikedDoctorsViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import Foundation

class LikedDoctorsListViewModel {
   
    @Published private(set) var openDeleteActionPanModal = false
    @Published private(set) var likedDoctorsData: [SingleDoctorResponse] = []
    
    private let doctorRepository: DoctorRepository
    private var doctorID: Int?
    
    init(doctorRepository: DoctorRepository) {
        self.doctorRepository = doctorRepository
        getLikedDoctors()
    }
    
    func doctorCardDidSelected(with doctorID: Int) {
        self.doctorID = doctorID
        openDeleteActionPanModal = true
    }
}

extension LikedDoctorsListViewModel {
    func getLikedDoctors() {
        /*
         doctorNetworkService.getLikedDoctors(limit: 0, page: 0) {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 self.likedDoctorsData = data
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
    
    func likeDoctor(isFavorite: Bool) {
       /*
        guard let doctorID else { return }
        doctorNetworkService.likeDoctor(doctorID: doctorID, isFavorite: isFavorite) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                print(data.message)
                getLikedDoctors()
            case .failure(let failure):
                print(failure)
            }
        }
        */
    }
}
