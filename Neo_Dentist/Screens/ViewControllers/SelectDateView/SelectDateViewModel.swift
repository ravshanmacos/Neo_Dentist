//
//  SelectDateViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 30/12/23.
//

import Foundation

class SelectDateViewModel {
    
    //MARK: Properties
    @Published private(set) var activateHoursView = false
    @Published private(set) var activateNextButton = false
    
    @Published private(set) var doctorDescription: SingleDoctorDescriptionResponse?
    @Published private(set) var doctorAvailableHours: [AvailableHoursResponse]?
    
    private let doctorRepository: DoctorRepository
    private let goToAppointmentDetailsNavigator: GoToAppointmentDetailsNavigator
    
    private var selectedDay: Int?
    var selectedTime: AvailableHoursResponse?
    
    var doctorID: Int? 
    
    private let calendarConfigure = CalendarConfigure.shared
    
    //MARK: Methods
    init(doctorRepository: DoctorRepository,
         goToAppointmentDetailsNavigator: GoToAppointmentDetailsNavigator) {
        self.doctorRepository = doctorRepository
        self.goToAppointmentDetailsNavigator = goToAppointmentDetailsNavigator
    }
    
    func dayIsSelected(dayNumber: Int) {
        selectedDay = dayNumber
        getDoctorAvailableHours()
        activateHoursView = true
    }
    
    func timeIsSelected(chosen: AvailableHoursResponse) {
        selectedTime = chosen
        activateNextButton = true
    }
    
    func getFormattedTimeSlot() -> String? {
        guard let selectedDay, let selectedTime else { return nil }
        let year = calendarConfigure.getYear()
        let month = calendarConfigure.getMonth()
        return calendarConfigure.encodeAppointmentTimeSlot(year: year, month: month, day: selectedDay, timeString: selectedTime.timeSlot)
    }
    
    @objc func nextButtonTapped() {
        goToAppointmentDetailsNavigator.navigateToAppointmentDetails()
    }
    
}

//MARK: Networking

extension SelectDateViewModel {
    
    func getDoctorAvailableHours() {
        doctorRepository
            .getDoctorAvailableHours(with: 2)
            .done { response in
                self.doctorAvailableHours = response
            }.catch { error in
                print(error)
            }
        /*
         guard let doctorID else { return }
         doctorNetworkService.getDoctorAvailableHours(doctorID: doctorID) {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 self.doctorAvailableHours = data
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
    
    func getDoctorDescription() {
        /*
         guard let doctorID else { return }
         doctorNetworkService.getDoctorDescription(id: doctorID) {[weak self] result in
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
