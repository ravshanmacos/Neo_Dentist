//
//  InfoFromUserViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import Foundation

class UserInfoViewModel {
    
    @Published private(set) var openCheckView = false
    @Published private(set) var updateView = false
    
    var firstName: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var phoneNumberCode: String = ""
    
    private let appointmentsNetworkService: AppointmentsNetworkService
    var appointmentRequest: MakeAppointmentRequest?
    var appointmentResponse: AppointmentsResponse?
    
    init(appointmentsNetworkService: AppointmentsNetworkService = AppointmentsNetworkServiceImplementation()) {
        self.appointmentsNetworkService = appointmentsNetworkService
        firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName) ?? ""
        lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastName) ?? ""
        phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.phoneNumber) ?? ""
    }
    
    func nextButtonTapped() {
        guard isRequestValidate() else { return }
        if let request = createAppointmentRequest() {
            createAppointment(request: request)
            openCheckView = true
        }
    }
    
    private func isRequestValidate() -> Bool {
        guard firstName != "",
              lastName != "",
              phoneNumberCode != "",
              phoneNumber != ""
        else {print("Oop!"); return false }
        return true
    }
    
    private func createAppointmentRequest() -> MakeAppointmentRequest? {
        guard var appointmentRequest else { return nil }
        appointmentRequest.patientFirstName = firstName
        appointmentRequest.patientLastName = lastName
        appointmentRequest.patientPhoneNumber = (/*phoneNumberCode*/ "+998" + phoneNumber).split(separator: " ").joined()
        return appointmentRequest
    }
}

extension UserInfoViewModel {
    func createAppointment(request: MakeAppointmentRequest) {
        appointmentsNetworkService.createAppointment(appointmentRequest: request)
        {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                appointmentResponse = data
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

