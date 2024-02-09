//
//  MainFactories.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import Foundation

//func makeSelectServicesViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest ) -> SelectServicesViewController

protocol TabBarFactory {
    func makeMainViewController() -> MainScreenViewController
    func makeAppointmentDetailsViewController(isFromSecondTab: Bool, appointmentRequest: MakeAppointmentRequest) -> AppointmentDetailsViewController
    func makeAppointmentHistoriesViewController() -> AppointmentHistoriesViewController
    func makeUserProfileViewController() -> UserProfileViewController
}

protocol MainFactory {
    func makeLikedDoctorsViewController() -> LikedDoctorsListViewController
    func makeSelectDoctorViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> DoctorsListViewController
    func makeSelectServicesViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest ) -> ClinicServicesListViewController
    func makeInfoAboutServiceViewController(isModifying: Bool, serviceID: Int, isFromDoctor: Bool, isFromClinicService: Bool, isFromMain: Bool) -> ClinicServiceViewController
    func makeInfoAboutDoctorViewController(isModifying: Bool, doctorID: Int, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> DoctorViewController
}

protocol ClinicServiceFactory {
    func makeInfoAboutServiceViewController(isModifying: Bool, serviceID: Int, isFromDoctor: Bool, isFromClinicService: Bool, isFromMain: Bool) -> ClinicServiceViewController
    func makeSelectDoctorViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> DoctorsListViewController
    func makeAppointmentDetailsViewController(isFromSecondTab: Bool, appointmentRequest: MakeAppointmentRequest) -> AppointmentDetailsViewController
}

protocol SelectDoctorFactory {
    func makeInfoAboutDoctorViewController(isModifying: Bool, doctorID: Int, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> DoctorViewController
    func makeFilterDoctorViewController() -> FilterDoctorsViewController
}

protocol InfoAboutDoctorFactory {
    func makeSelectDateViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> SelectDateViewController
    
}

protocol SelectDateFactory {
    func makeAppointmentDetailsViewController(isFromSecondTab: Bool, appointmentRequest: MakeAppointmentRequest) -> AppointmentDetailsViewController
    func makeSelectServicesViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest ) -> ClinicServicesListViewController
}

protocol AppoinmentDetailsFactory {
    
    func makeSelectDoctorViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> DoctorsListViewController
    
    func makeSelectServicesViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest ) -> ClinicServicesListViewController
    
    func makeSelectDateViewController(isModifying: Bool, isFromDoctor: Bool, isFromClinicService: Bool, appointmentRequest: MakeAppointmentRequest) -> SelectDateViewController
   
    func makeInfoFromUserViewController(appointmentRequest: MakeAppointmentRequest) -> UserInfoViewController
}

protocol InfoFromUserFactory {
    func makeCheckViewController(appoinmentResponse: AppointmentsResponse, isFromTab: Bool) -> CheckViewController
}

protocol UserProfileFactory {
    func makeEditUserProfileViewController() -> EditUserProfileViewController
}

protocol FilterDoctorsFactory {
    func makeSpecializationViewController() -> SpecializationViewController
    func makeExperienceViewController() -> ExperienceViewController
}

protocol CheckViewFactory {
    func makeMainViewController() -> MainScreenViewController
}

