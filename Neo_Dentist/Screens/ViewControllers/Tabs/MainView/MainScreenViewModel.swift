//
//  MainViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import Foundation

typealias MainScreenNavigationAction = NavigationAction<MainScreenViewState>

class MainScreenViewModel {
    
    //MARK: Properties
    @Published private(set) var openCurrentView = false
    
    @Published private(set) var clinicServices: [SingleServiceResponse] = []
    @Published private(set) var recomendedDoctors: SingleDoctorResponse?
    @Published private(set) var advertisement: AdvertisementResponse?
    
    @Published private(set) var navigationAction: MainScreenNavigationAction?
    
    private let serviceRepository: ServicesRepository
    private let doctorRepository: DoctorRepository

    var appointmentRequest: MakeAppointmentRequest
    
    //MARK: Methods
    init(
        serviceRepository: ServicesRepository,
        doctorRepository: DoctorRepository,
        appointmentRequest: MakeAppointmentRequest) {
            self.serviceRepository = serviceRepository
            self.doctorRepository = doctorRepository
            self.appointmentRequest = appointmentRequest
            setupListeners()
            getServices()
            getAdvertisement()
            getRecomendedDoctors()
        }
    
    private func setupListeners() {
        NotificationCenter.default.addObserver(self, selector: #selector(navigateToSelectDoctorView),
                                               name: NSNotification.Name ("openSelectDoctorViewFromMain"), object: nil)
    }
    
    func serviceTapped(with serviceID: Int) {
        navigateToSingleService(serviceID: serviceID)
//        self.serviceID = serviceID
//        isFromDoctor = false
//        isFromClinicService = true
//        appointmentRequest.emptyAppointmentRequest()
//        appointmentRequest.doctorID = serviceID
//        self.openInfoAboutService = true
    }
    
}

//MARK: Navigations
extension MainScreenViewModel: GoToServicesListNavigator, GoToSingleServiceNavigator, GoToDoctorsListNavigator, GoToSingleDoctorNavigator, GoToSelectDateNavigator, GoToAppointmentDetailsNavigator {
    func navigateToServicesList() {
        navigationAction = .present(view: .clinicServicesListView)
    }
    
    func navigateToSingleService(serviceID: Int) {
        navigationAction = .present(view: .clinicServiceView(serviceID: serviceID))
    }
    
    func navigateToDoctorsList() {
        navigationAction = .present(view: .doctorsListView)
    }
    
    func navigateToSingleDoctor(doctorID: Int) {
        navigationAction = .present(view: .doctorView(doctorID: doctorID))
    }
    
    func navigateToSelectDate() {
        navigationAction = .present(view: .selectDateView)
    }
    
    func navigateToAppointmentDetails() {
        navigationAction = .present(view: .appointmentDetailsView)
    }
}

//MARK: Actions
@objc extension MainScreenViewModel {
    
    func openCurrentViewTapped() {
        
    }
    
    func openLikedDoctorsTapped() {
        
    }
    
    func openAllServicesTapped() {
        navigateToServicesList()
//        isFromDoctor = false
//        isFromClinicService = true
//        appointmentRequest.emptyAppointmentRequest()
//        openAllServices = true
    }
    
    func openDoctorsListTapped() {
        navigateToDoctorsList()
//        isFromDoctor = true
//        isFromClinicService = false
//        appointmentRequest.emptyAppointmentRequest()
//        openDoctorsList = true
    }
    
    func recomendedDoctorTapped() {
        navigateToSingleDoctor(doctorID: 2)
//        guard let doctor = recomendedDoctors else { return }
//        self.doctorID = doctor.id
//        isFromDoctor = true
//        isFromClinicService = false
//        appointmentRequest.emptyAppointmentRequest()
//        appointmentRequest.doctorID = doctor.id
//        openInfoAboutDoctor = true
    }
    
    func navigateToSelectDoctorView(_ notification: NSNotification) {
//        appointmentRequest.emptyAppointmentRequest()
//        if let id = notification.userInfo?["serviceID"] as? Int {
//            self.serviceID = id
//            appointmentRequest.serviceID = id
//            openDoctorsList = true
//        }
    }
}

//MARK: Networking
private extension MainScreenViewModel {
    func getServices() {
        serviceRepository
            .getServices(limit: 6)
            .done { response in
                self.clinicServices = response.services
            }.catch { error in
                print(error)
            }
        /*
         clinicNetworkService.getServices(limit: 6) {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 self.clinicServices = data.services
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
    
    func getAdvertisement() {
        /*
         generalNetworkService.getAdvertisement {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 self.advertisement = data
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
    
    func getRecomendedDoctors() {
        doctorRepository
            .getRecomendedDoctors()
            .done { response in
                self.recomendedDoctors = response
            }.catch { error in
                print(error)
            }
        /*
         doctorsNetworkService.getRecomendedDoctors {[weak self] result in
             guard let self else { return }
             switch result {
             case .success(let data):
                 self.recomendedDoctors = data
             case .failure(let failure):
                 print(failure)
             }
         }
         */
    }
}
