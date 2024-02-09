//
//  UserProfileViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/01/24.
//

import Foundation
import UIKit

class UserProfileViewModel {
    @Published private(set) var openCancelView = false
    @Published private(set) var openEditProfileView = false
    @Published private(set) var logout = false
    @Published private(set) var updateView = false
    @Published private(set) var updateTableView = false
    
    
    private let userNetworkService: UserNetworkService
    private let appointmentNetworkService: AppointmentsNetworkService
    
    var firstName = ""
    var lastName = ""
    var userName = ""
    var phoneNumber = ""
    
    var appointmentID: Int?
    var cardIndex: Int?
    
    var appointments: [AppointmentsResponse] = [] {
        didSet {
            updateTableView = true
        }
    }
    
    
    init(userNetworkService: UserNetworkService = UserNetworkServiceImplementation(), appointmentNetworkService: AppointmentsNetworkService = AppointmentsNetworkServiceImplementation()) {
        self.userNetworkService = userNetworkService
        self.appointmentNetworkService = appointmentNetworkService
    }
    
}

@objc extension UserProfileViewModel {
    func editProfileButtonTapped () {
        openEditProfileView = true
    }
    
    func cancelButtonTapped (_ sender: UIButton) {
        cardIndex = sender.titleLabel?.tag
        appointmentID = sender.tag
        openCancelView = true
    }
    
    func logoutButtonTapped() {
        logout = true
    }
}

extension UserProfileViewModel {
    func getUserProfile() {
        userNetworkService.getUserProfileLong {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                self.firstName = data.firstName
                self.lastName = data.lastName
                self.userName = data.username
                self.phoneNumber = data.phoneNumber
                self.appointments = data.appointments
                updateView = true
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func deleteAppointment(id: Int) {
        appointmentNetworkService.deleteAppointment(id: id) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                print("Deleted SuccessFully")
                getUserProfile()
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
