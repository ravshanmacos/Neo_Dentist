//
//  SelectDateViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 30/12/23.
//

import UIKit
import Combine

protocol SelectDateViewModelFactory {
    func makeSelectDateViewModel() -> SelectDateViewModel
}

class SelectDateViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: SelectDateViewModelFactory
    private let viewModel: SelectDateViewModel
    private let rootView: SelectDateRootView
   
    private var appointmentRequest: MakeAppointmentRequest
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModelFactory: SelectDateViewModelFactory,
         appointmentRequest: MakeAppointmentRequest
    ){
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeSelectDateViewModel()
        
        self.appointmentRequest = appointmentRequest
        self.rootView = SelectDateRootView(viewModel: viewModel)
        super.init()
        viewModel.doctorID = appointmentRequest.doctorID
        bindOpenAppointmentDetailsView()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setTitle(text: "Выберите дату и время")
        setBackButton()
        
        print(appointmentRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDoctorDescription()
    }
}

//MARK: Navigations
extension SelectDateViewController {
    func bindOpenAppointmentDetailsView() {
        /*
         viewModel
             .$openView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 guard let selectedTimeSlot = viewModel.getFormattedTimeSlot() else { return }
                 if viewModel.isModifying {
                     let dateString: [String: String] = ["dateString": selectedTimeSlot]
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DateSelected"), object: nil, userInfo: dateString)
                 } else {
                     appointmentRequest.appointmentTime = selectedTimeSlot
                     if isFromDoctor {
                         navigationController?.pushViewController(factory.makeSelectServicesViewController(isModifying: viewModel.isModifying, isFromDoctor: true, isFromClinicService: false, appointmentRequest: appointmentRequest), animated: true)
                     }
                     
                     if isFromClinicService {
                         
                         navigationController?.pushViewController(factory.makeAppointmentDetailsViewController(isFromSecondTab: false, appointmentRequest: appointmentRequest), animated: true)
                     }
                     
                 }
                 
             }.store(in: &subscriptions)
         */
    }
}
