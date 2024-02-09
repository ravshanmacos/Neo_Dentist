//
//  AppointmentDetailsViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit
import Combine

protocol AppointmentViewModelFactory {
    func makeAppointmentViewModel() -> AppointmentDetailsViewModel
}

class AppointmentDetailsViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModel: AppointmentDetailsViewModel
    private let viewModelFactory: AppointmentViewModelFactory
    private var appointmentRequest: MakeAppointmentRequest?
    
    private var appointmentDetailsRootView: AppointmentDetailsRootView {
        return view as! AppointmentDetailsRootView
    }
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModelFactory: AppointmentViewModelFactory,
         appointmentRequest: MakeAppointmentRequest?){
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeAppointmentViewModel()
        self.appointmentRequest = appointmentRequest
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = AppointmentDetailsRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(text: "Запись на прием 🗓️")
        print(appointmentRequest)
    }
}

//MARK: Navigations
/*
 extension AppointmentDetailsViewController {
     func bindNavigations() {
         bindOpenAppointmentDetailsView()
         bindOpenModifyingView()
         bindNavigateCurrentView()
     }
     
     func bindOpenAppointmentDetailsView() {
         viewModel
             .$openInfoFromUser
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 guard let serviceID = viewModel.serviceID,
                         let doctorID = viewModel.doctorID,
                         let timeSlot = viewModel.timeSlot
                 
                 else { print("nil found"); return }
                 appointmentRequest.doctorID = doctorID
                 appointmentRequest.serviceID = serviceID
                 appointmentRequest.appointmentTime = timeSlot
                 navigationController?.pushViewController(factory.makeInfoFromUserViewController(appointmentRequest: appointmentRequest), animated: true)
             }.store(in: &subscriptions)
     }
     
     func bindOpenModifyingView() {
         viewModel
             .$indexPath
             .receive(on: DispatchQueue.main)
             .sink { [weak self] indexPath in
                 guard let self, let indexPath else { return }
                 switch indexPath.row {
                 case 0: print("dfafa")
                     //navigationController?.pushViewController(factory.makeSelectDoctorViewController(isModifying: true, isFromDoctor: false, isFromClinicService: false, appointmentRequest: appointmentRequest), animated: true)
                 case 1: print("dfafa")
                     //navigationController?.pushViewController(factory.makeSelectServicesViewController(isModifying: true, isFromDoctor: false, isFromClinicService: false, appointmentRequest: appointmentRequest), animated: true)
                 case 2: print("dfafa")
                     guard let doctorID = viewModel.doctorID else { return }
                     appointmentRequest.doctorID = doctorID
                     //navigationController?.pushViewController(factory.makeSelectDateViewController(isModifying: true, isFromDoctor: false, isFromClinicService: false, appointmentRequest: appointmentRequest), animated: true)
                 default: return
                 }
             }.store(in: &subscriptions)
     }
     
     func bindNavigateCurrentView() {
         viewModel
             .$navigateCurrentView
             .receive(on: DispatchQueue.main)
             .sink { [weak self] open in
                 guard let self, open else { return }
                 navigationController?.popToViewController(self, animated: true)
             }.store(in: &subscriptions)
     }
 }
 */

