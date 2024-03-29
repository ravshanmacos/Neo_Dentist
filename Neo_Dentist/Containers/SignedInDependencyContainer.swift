//
//  SignedInDependencyContainer.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/02/24.
//

import Foundation

class SignedInDependencyContainer {
    
    //MARK: Properties
    private let sharedUserSessionRepository: UserSessionRepository
    private let sharedServiceRepository: ServicesRepository
    private let sharedDoctorRepository: DoctorRepository
    
    private let sharedMainViewModel: MainManagerViewModel
    private let sharedUserSession: UserSession
    private let appointmentRequestModel: MakeAppointmentRequest
    private let sharedMainScreenViewModel: MainScreenViewModel
   
    
    //MARK: Methods
    init(userSession: UserSession, appDependencyContainer: AppDependencyContainer) {
        
        //Doctor Repository
        func makeDoctorRepository() -> DoctorRepository {
            let remoteAPI = makeDoctorRemoteAPI()
            return NeoDentistDoctorRepository(remoteAPI: remoteAPI)
        }
        
        func makeDoctorRemoteAPI() -> DoctorRemoteAPI {
            return FakeDoctorRemoteAPI()
        }
        
        //Service Repository
        func makeServiceRepository() -> ServicesRepository {
            let remoteAPI = makeServiceRemoteAPI()
            return NeoDentistServiceRepository(remoteAPI: remoteAPI)
        }
        
        func makeServiceRemoteAPI() -> ServiceRemoteAPI {
            return FakeServiceRemoteAPI()
        }
        
        //AppointmentRequest
        func makeAppointmentRequestModel() -> MakeAppointmentRequest {
            return MakeAppointmentRequest(doctorID: 0, serviceID: 0, appointmentTime: "", patientFirstName: "", patientLastName: "", patientPhoneNumber: "")
        }
        
        //Initializing
        self.sharedUserSession = userSession
        self.sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
        self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
        
        self.sharedServiceRepository = makeServiceRepository()
        self.sharedDoctorRepository = makeDoctorRepository()
        
        self.appointmentRequestModel = makeAppointmentRequestModel()
        self.sharedMainScreenViewModel = MainScreenViewModel(serviceRepository: sharedServiceRepository, doctorRepository: sharedDoctorRepository, appointmentRequest: appointmentRequestModel)
    }
    
    //TabBar View Controller
    func makeTabBarViewController() -> TabbarController {
        let mainScreenViewController = makeMainScreenViewController()
        let makeAppointmentViewController = makeAppointmentViewController()
        let AppointmentHistoriesViewController = makeAppointmentHistoriesViewController()
        let userProfileViewController = makeUserProfileViewController()
        return TabbarController(mainScreenViewController: mainScreenViewController,
                                makeAppointmentViewController: makeAppointmentViewController,
                                appointmentHistoriesViewController: AppointmentHistoriesViewController,
                                userProfileViewController: userProfileViewController)
    }
    
    //Main Screen
    func makeMainScreenViewController() -> MainScreenViewController {
        let clinicServicesListViewControllerFactory = {
            return self.makeClinicServicesListViewController()
        }
        
        let clinicServiceViewControllerFactory = { (serviceID: Int) in
            return self.makeClinicServiceViewController(serviceID: serviceID)
        }
        
        let doctorsListViewControllerFactory = {
            return self.makeDoctorsListViewController()
        }
        
        let doctorViewControllerFactory = { (doctorID: Int) in
            return self.makeDoctorViewController(doctorID: doctorID)
        }
        
        let selectDateViewControllerFactory = {
            return self.makeSelectDateViewController()
        }
        
        let appointmentDetailsControllerFactory = {
            return self.makeAppointmentViewController()
        }
        
        return MainScreenViewController(viewModel: sharedMainScreenViewModel, clinicServicesListViewControllerFactory: clinicServicesListViewControllerFactory, clinicServiceViewControllerFactory: clinicServiceViewControllerFactory, doctorsListViewControllerFactory: doctorsListViewControllerFactory, doctorViewControllerFactory: doctorViewControllerFactory, selectDateViewControllerFactory: selectDateViewControllerFactory, appointmentDetailsControllerFactory: appointmentDetailsControllerFactory)
    }
    
    //Make Appointment
    func makeAppointmentViewController() -> AppointmentDetailsViewController {
        return AppointmentDetailsViewController(viewModelFactory: self,
                                                appointmentRequest: appointmentRequestModel)
    }
    
    func makeAppointmentViewModel() -> AppointmentDetailsViewModel {
        return AppointmentDetailsViewModel(isFromSecondTab: true,
                                           serviceRepository: sharedServiceRepository,
                                           doctorRepository: sharedDoctorRepository)
    }
    
    //Appointments History
    func makeAppointmentHistoriesViewController() -> AppointmentHistoriesViewController {
        return AppointmentHistoriesViewController(viewModelFactory: self)
    }
    
    func makeAppointmentHistoriesViewModel() -> AppointmentHistoriesViewModel {
        return AppointmentHistoriesViewModel()
    }
    
    //User Profile
    func makeUserProfileViewController() -> UserProfileViewController {
        return UserProfileViewController(viewModelFactory: self)
    }
    
    func makeUserProfileViewModel() -> UserProfileViewModel {
        return UserProfileViewModel()
    }
}

extension SignedInDependencyContainer: AppointmentViewModelFactory, AppointmentHistoriesViewModelFactory, UserProfileViewModelFactory {}

//MARK: Reusable View Controllers
extension SignedInDependencyContainer {
    //Clinic Services List View
    func makeClinicServicesListViewController() -> ClinicServicesListViewController {
        return ClinicServicesListViewController(viewModelFactory: self, appointmentRequest: appointmentRequestModel)
    }
    
    func makeClinicServicesListViewModel() -> ClinicServicesListViewModel {
        return ClinicServicesListViewModel(servicesRepository: sharedServiceRepository, goToSingleServiceNavigator: sharedMainScreenViewModel)
    }
    
    //Single Clinic Service View
    func makeClinicServiceViewController(serviceID: Int) -> ClinicServiceViewController {
        return ClinicServiceViewController(serviceID: serviceID, viewModelFactory: self)
    }
    
    func makeClinicServiceViewModel(serviceID: Int) -> ClinicServiceViewModel {
        return ClinicServiceViewModel(serviceID: serviceID, servicesRepository: sharedServiceRepository, goToDoctorsListNavigator: sharedMainScreenViewModel)
    }
    
    //Doctors List View
    func makeDoctorsListViewController() -> DoctorsListViewController {
        return DoctorsListViewController(viewModelFactory: self, appointmentRequest: appointmentRequestModel)
    }
    
    func makeDoctorsListViewModel() -> DoctorsListViewModel {
        return DoctorsListViewModel(doctorRepository: sharedDoctorRepository, goToSingleDoctorNavigator: sharedMainScreenViewModel)
    }
    
    //Single Doctor View
    func makeDoctorViewController(doctorID: Int) -> DoctorViewController {
        return DoctorViewController(doctorID: doctorID, viewModelFactory: self, appointmentRequest: appointmentRequestModel)
    }
    
    func makeDoctorViewModel(doctorID: Int) -> DoctorViewModel {
        return DoctorViewModel(doctorId: doctorID, doctorRepository: sharedDoctorRepository, goToSelectDateNavigator: sharedMainScreenViewModel)
    }
    
    //Like Doctor View
    func makeLikedDoctorsListViewController() -> LikedDoctorsListViewController {
        return LikedDoctorsListViewController(viewModelFactory: self)
    }
    
    func makeLikedDoctorsListViewModel() -> LikedDoctorsListViewModel {
        return LikedDoctorsListViewModel(doctorRepository: sharedDoctorRepository)
    }
    
    //Appointment Date View
    func makeSelectDateViewController() -> SelectDateViewController {
        return SelectDateViewController(viewModelFactory: self, appointmentRequest: appointmentRequestModel)
    }
    
    func makeSelectDateViewModel() -> SelectDateViewModel {
        return SelectDateViewModel(doctorRepository: sharedDoctorRepository, goToAppointmentDetailsNavigator: sharedMainScreenViewModel)
    }
    //UserInfoView
    func makeUserInfoViewController() -> UserInfoViewController {
        return UserInfoViewController(viewModelFactory: self, appointmentRequest: appointmentRequestModel)
    }
    
    func makeUserInfoViewModel() -> UserInfoViewModel {
        return UserInfoViewModel()
    }
    //CheckView
    func makeCheckViewController() -> CheckViewController {
        let doctor = Doctor(id: 2, fullName: "Смирнова Анна Ивановна")
        let service = Service(id: 1, name: "Пломбирование зубов")
        
        let appointmentResponse = AppointmentsResponse(id: 1, doctor: doctor, service: service, appointmentTime: "2024-01-22T13:00:00Z", patientFirstName: "Бексултан", patientLastName: "Маратов", patientPhoneNumber: "+996555749509", address: "Киевская 108/1а", status: "pending")
        return CheckViewController(appoinmentResponse: appointmentResponse)
    }
}

extension SignedInDependencyContainer: ClinicServicesViewModelFactory, ClinicServiceViewModelFactory, DoctorsListViewModelFactory, DoctorViewModelFactory, LikedDoctorsListViewModelFactory, SelectDateViewModelFactory, UserInfoViewModelFactory {}
