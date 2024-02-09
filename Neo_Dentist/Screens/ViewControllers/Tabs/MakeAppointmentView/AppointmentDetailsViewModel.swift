//
//  AppointmentDetailsViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import Foundation

class AppointmentDetailsViewModel {
    
    @Published private(set) var openInfoFromUser = false
    @Published private(set) var navigateCurrentView = false
    @Published var updateTableView = false
    @Published private(set) var indexPath: IndexPath? = nil
    
    private let serviceRepository: ServicesRepository
    private let doctorRepository: DoctorRepository
    
    private var selectedDoctor = ""
    private var selectedService = ""
    private var selectedDate = ""
    private let calendarConfigure = CalendarConfigure.shared
    
    var doctorID: Int?
    var serviceID: Int?
    var timeSlot: String?
    
    var isFromSecondTab: Bool
    var appointmentData: [AppointmentInfo] = ConstantDatas.defaultAppointmentDetailsData
    
    init(isFromSecondTab: Bool, 
         serviceRepository: ServicesRepository,
         doctorRepository: DoctorRepository
    ){
        self.isFromSecondTab = isFromSecondTab
        self.serviceRepository = serviceRepository
        self.doctorRepository = doctorRepository
        setupListeners()
    }
    
    private func setupListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.onServiceSelection(_:)), name: NSNotification.Name(rawValue: "ServiceSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onDoctorSelection(_:)), name: NSNotification.Name(rawValue: "DoctorSelected"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.onDateSelection(_:)), name: NSNotification.Name(rawValue: "DateSelected"), object: nil)
    }
    
    func didSelect(at indexPath: IndexPath) {
        self.indexPath = indexPath
    }
    
    func setSelectedDate(timeSlot: String) {
        selectedDate = calendarConfigure.decodeAppointmentTimeSlot(dateString: timeSlot) ?? ""
        appointmentData[2].description = calendarConfigure.decodeAppointmentTimeSlot(dateString: timeSlot) ?? ""
        updateTableView = true
    }
    
    func emptyAppointment() {
        selectedDoctor = ""
        selectedService = ""
        selectedDate = ""
    }
}

//MARK: Actions
@objc extension AppointmentDetailsViewModel {
    func nextButtonTapped() {
        guard selectedDoctor != "" && selectedService != "", selectedDate != "" else { return }
        openInfoFromUser = true
    }
    
    func onServiceSelection(_ notification: NSNotification) {
        if let serviceID = notification.userInfo?["serviceID"] as? Int {
            self.serviceID = serviceID
            getServiceInfo(serviceID: serviceID)
            navigateCurrentView = true
        }
    }
    
    func onDoctorSelection(_ notification: NSNotification) {
        if let doctorID = notification.userInfo?["doctorID"] as? Int {
            self.doctorID = doctorID
            getDoctorDescription(doctorID: doctorID)
            navigateCurrentView = true
        }
    }
    
    func onDateSelection(_ notification: NSNotification) {
        if let dateString = notification.userInfo?["dateString"] as? String {
            timeSlot = dateString
            selectedDate = calendarConfigure.decodeAppointmentTimeSlot(dateString: dateString) ?? ""
            appointmentData[2].description = calendarConfigure.decodeAppointmentTimeSlot(dateString: dateString) ?? ""
            updateTableView = true
            navigateCurrentView = true
        }
    }
}

extension AppointmentDetailsViewModel {
    func getDoctorDescription(doctorID: Int) {
        /*
         doctorNetworkService.getDoctorDescription(id: doctorID) {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 selectedDoctor = data.fullname
                 appointmentData[0].description = data.fullname
                 updateTableView = true
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
    
    func getServiceInfo(serviceID: Int) {
       /*
        clinicNetworkService.getService(serviceID: serviceID) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                selectedService = data.name
                appointmentData[1].description = data.name
                updateTableView = true
            case .failure(let failure):
                print(failure)
            }
        }
        */
    }
}
