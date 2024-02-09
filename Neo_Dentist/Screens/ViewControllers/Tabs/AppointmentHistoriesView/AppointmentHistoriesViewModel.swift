//
//  AppointmentHistories.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import Foundation
import UIKit

enum AppointmentStatus: String {
    case pending = "pending"
    case completed = "completed"
    case canceled = "canceled"
}

class AppointmentHistoriesViewModel {
    
    @Published private(set) var openCancelView = false
    @Published private(set) var updateTableView = false
    
    private let appointmentNetworkService: AppointmentsNetworkService
    private var appointmentsOriginal: [AppointmentsResponse] = []
    var appointments: [AppointmentsResponse] = [] {
        didSet {
            updateTableView = true
        }
    }
    var appointmentID: Int?
    
    init(appointmentNetworkService: AppointmentsNetworkService = AppointmentsNetworkServiceImplementation()) {
        self.appointmentNetworkService = appointmentNetworkService
       
        getAppointments(status: AppointmentStatus.pending.rawValue)
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        appointmentID = sender.tag
        openCancelView = true
    }
    
    func filterAppointments(status: AppointmentStatus) {
        appointments = []
        getAppointments(status: status.rawValue)
    }
    
}

extension AppointmentHistoriesViewModel {
    func getAppointments(status: String) {
        appointmentNetworkService.getAppointments(status: status) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                appointments = data
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
                filterAppointments(status: .pending)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
