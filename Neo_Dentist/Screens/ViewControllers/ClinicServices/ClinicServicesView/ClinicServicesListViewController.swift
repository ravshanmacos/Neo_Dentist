//
//  ClinicServicesViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit
import Combine

protocol ClinicServicesViewModelFactory {
    func makeClinicServicesListViewModel() -> ClinicServicesListViewModel
}

class ClinicServicesListViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: ClinicServicesViewModelFactory
    private let viewModel: ClinicServicesListViewModel
    private let rootView: ClinicServicesListRootView
    
    var appointmentRequest: MakeAppointmentRequest
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModelFactory: ClinicServicesViewModelFactory,
         appointmentRequest: MakeAppointmentRequest
    ){
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeClinicServicesListViewModel()
        self.appointmentRequest = appointmentRequest
        self.rootView = ClinicServicesListRootView(viewModel: viewModel)
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(text: "Услуги клиники")
        setBackButton()
    }
}

/*
 func bindNavigations() {
     bindOpenClinicService()
     bindOpenSelectDoctorView()
 }
 
 func bindOpenClinicService() {
     viewModel
         .$openInfoAboutService
         .receive(on: DispatchQueue.main)
         .sink { [weak self] open in
             guard let self, let serviceID = viewModel.serviceID, open else { return }
             navigationController?.presentPanModal(factory.makeInfoAboutServiceViewController(isModifying: viewModel.isModifying, serviceID: serviceID, isFromDoctor: isFromDoctor, isFromClinicService: isFromClinicService, isFromMain: false))
         }.store(in: &subscriptions)
 }
 
 func bindOpenSelectDoctorView() {
     viewModel
         .$openSelectDoctorView
         .receive(on: DispatchQueue.main)
         .sink { [weak self] open in
             guard let self, open else { return }
             guard let serviceID = viewModel.serviceID else { return }
             appointmentRequest.serviceID = serviceID
             navigationController?.pushViewController(factory.makeSelectDoctorViewController(isModifying: viewModel.isModifying, isFromDoctor: isFromDoctor, isFromClinicService: isFromClinicService, appointmentRequest: appointmentRequest), animated: true)
         }.store(in: &subscriptions)
     
     
     viewModel
         .$openAppointmentView
         .receive(on: DispatchQueue.main)
         .sink { [weak self] open in
             guard let self, open else { return }
             guard let serviceID = viewModel.serviceID else { return }
             appointmentRequest.serviceID = serviceID
             navigationController?.pushViewController(factory.makeAppointmentDetailsViewController(isFromSecondTab: false, appointmentRequest: appointmentRequest), animated: true)
         }.store(in: &subscriptions)
     
 }
 */
