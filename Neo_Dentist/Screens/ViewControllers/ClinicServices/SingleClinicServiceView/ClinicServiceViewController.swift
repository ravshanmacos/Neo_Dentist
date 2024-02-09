//
//  InfoAboutServiceViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import Foundation
import Combine
import PanModal

protocol ClinicServiceViewModelFactory {
    func makeClinicServiceViewModel(serviceID: Int) -> ClinicServiceViewModel
}

class ClinicServiceViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: ClinicServiceViewModelFactory
    private let viewModel: ClinicServiceViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(serviceID: Int,
         viewModelFactory: ClinicServiceViewModelFactory){
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeClinicServiceViewModel(serviceID: serviceID)
        super.init()
        print("serviceID: \(serviceID)")
        observeDissmissing()
    }
    
    override func loadView() {
        super.loadView()
        view = ClinicServiceRootView(viewModel: viewModel)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getServiceInfo()
    }
}

extension ClinicServiceViewController {
    func observeDissmissing() {
        viewModel
            .$dismissPandModal
            .receive(on: DispatchQueue.main)
            .sink {[weak self] dissmiss in
                guard let self, dissmiss else { return }
                dismiss(animated: true)
            }.store(in: &subscriptions)
    }
}

extension ClinicServiceViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(view.screenHeight() * 4/6)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(view.screenHeight() * 5/6)
    }
}

/*
 viewModel
     .$openSelectDoctorView
     .receive(on: DispatchQueue.main)
     .sink {[weak self] open in
         guard let self, open else { return }
         dismiss(animated: true)
         let serviceID: [String: Int] = ["serviceID": viewModel.serviceID]
         if viewModel.isModifying {
             NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ServiceSelected"), object: nil, userInfo: serviceID)
         } else {
             if isFromDoctor {
                 NotificationCenter.default.post(name: NSNotification.Name("openAppointmentView"),
                              object: nil, userInfo: serviceID)
             }
             
             if isFromClinicService && isFromMain {
                 NotificationCenter.default.post(name: NSNotification.Name("openSelectDoctorViewFromMain"),
                              object: nil, userInfo: serviceID)
             } else {
                 NotificationCenter.default.post(name: NSNotification.Name("openSelectDoctorViewFromServiceCollection"),
                              object: nil, userInfo: serviceID)
             }
         }
     }.store(in: &subscriptions)
 */
