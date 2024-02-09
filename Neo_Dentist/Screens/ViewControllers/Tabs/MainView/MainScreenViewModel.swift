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
    
    @Published private(set) var navigationAction: MainScreenNavigationAction = .present(view: .initial)
    
    private let serviceRepository: ServicesRepository
    private let doctorRepository: DoctorRepository

    var appointmentRequest: MakeAppointmentRequest?
    var serviceID: Int?
    var doctorID: Int?
    
    //MARK: Methods
    init(
        serviceRepository: ServicesRepository,
        doctorRepository: DoctorRepository) {
            self.serviceRepository = serviceRepository
            self.doctorRepository = doctorRepository
        }
    
    func serviceTapped(with serviceID: Int) {
        navigateToSingleService(serviceID: serviceID)
    }
    
    func setInitialState() {
        serviceID = nil
        doctorID = nil
        appointmentRequest = nil
    }
    
}

//MARK: Actions
@objc extension MainScreenViewModel {
    
    func openLikedDoctorsTapped() {
        
    }
    
    func openAllServicesTapped() {
        navigateToServicesList()
    }
    
    func openDoctorsListTapped() {
        navigateToDoctorsList()
    }
    
    func recomendedDoctorTapped() {
        navigateToSingleDoctor(doctorID: 2)
    }
    
}

//MARK: Navigations
extension MainScreenViewModel: GoToServicesListNavigator, GoToSingleServiceNavigator, GoToDoctorsListNavigator, GoToSingleDoctorNavigator, GoToSelectDateNavigator, GoToAppointmentDetailsNavigator {
    func navigateToServicesList() {
        navigationAction = .present(view: .clinicServicesListView)
    }
    
    func navigateToSingleService(serviceID: Int) {
        self.serviceID = serviceID
        navigationAction = .present(view: .clinicServiceView)
    }
    
    func navigateToDoctorsList() {
        navigationAction = .present(view: .doctorsListView)
    }
    
    func navigateToSingleDoctor(doctorID: Int) {
        self.doctorID = doctorID
        navigationAction = .present(view: .doctorView)
    }
    
    func navigateToSelectDate() {
        navigationAction = .present(view: .selectDateView)
    }
    
    func navigateToAppointmentDetails() {
        navigationAction = .present(view: .appointmentDetailsView)
    }
}

//MARK: Networking
extension MainScreenViewModel {
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
