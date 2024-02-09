//
//  InfoAboutDoctorViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 29/12/23.
//

import UIKit
import Combine

protocol DoctorViewModelFactory {
    func makeDoctorViewModel(doctorID: Int) -> DoctorViewModel
}

class DoctorViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: DoctorViewModelFactory
    private let viewModel: DoctorViewModel
    private let rootView: DoctorRootView
    
    private var appointmentRequest: MakeAppointmentRequest
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(doctorID: Int,
         viewModelFactory: DoctorViewModelFactory,
         appointmentRequest: MakeAppointmentRequest
    ){
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeDoctorViewModel(doctorID: doctorID)
        self.appointmentRequest = appointmentRequest
        self.rootView = DoctorRootView(viewModel: viewModel)
        super.init()
        bindOpenSelectDateView()
        bindViewModelToView()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setBackButton()
        setRightButton()
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDoctorDescription()
    }
    
    override func likeButtonTapped() {
        super.likeButtonTapped()
        print("like Button Tapped")
        viewModel.likeDoctor(isFavorite: likeButton.isSelected)
    }
}

//MARK: Navigations
extension DoctorViewController {
    func bindOpenSelectDateView() {
        /*
         viewModel
             .$openSelectDateView
             .receive(on: DispatchQueue.main)
             .sink {[weak self] open in
                 guard let self, open else { return }
                 if viewModel.isModifying {
                     let doctorID: [String: Int] = ["doctorID": viewModel.doctorId]
                     NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DoctorSelected"), object: nil, userInfo: doctorID)
                 } else {
                     appointmentRequest.doctorID = viewModel.doctorId
                     navigationController?.pushViewController(factory.makeSelectDateViewController(isModifying: false, isFromDoctor: isFromDoctor, isFromClinicService: isFromClinicService, appointmentRequest: appointmentRequest), animated: true)
                 }
                 
             }.store(in: &subscriptions)
         */
    }
    
    func bindViewModelToView() {
        /*
         viewModel
             .$doctorDescription
             .receive(on: DispatchQueue.main)
             .sink {[weak self] doctorDescription in
                 guard let self, let doctorDescription else { return }
                 likeButton.isSelected = doctorDescription.isFavorite
             }.store(in: &subscriptions)
         */
    }
}
