//
//  SelectDoctorViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit
import Combine

protocol DoctorsListViewModelFactory {
    func makeDoctorsListViewModel() -> DoctorsListViewModel
}

class DoctorsListViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModelFactory: DoctorsListViewModelFactory
    private let viewModel: DoctorsListViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(viewModelFactory: DoctorsListViewModelFactory){
        self.viewModelFactory = viewModelFactory
        self.viewModel = viewModelFactory.makeDoctorsListViewModel()
        super.init()
        bindNavigations()
    }
    
    override func loadView() {
        super.loadView()
        view = DoctorsListRootView(viewModel: viewModel)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setTitle(text: "Выберите доктора")
        setBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getDoctors()
    }
}

//MARK: Navigations
extension DoctorsListViewController {
    func bindNavigations() {
       /*
        viewModel
            .$openFilterDoctorView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] open in
                guard let self, open else { return }
                //navigationController?.pushViewController(factory.makeFilterDoctorViewController(), animated: true)
            }.store(in: &subscriptions)
        
        viewModel
            .$openInfoAboutDoctorView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] open in
                guard let self, let id = viewModel.doctorID, open else { return }
                //navigationController?.pushViewController(factory.makeInfoAboutDoctorViewController(isModifying: viewModel.isModifying, doctorID: id, isFromDoctor: isFromDoctor, isFromClinicService: isFromClinicService, appointmentRequest: appointmentRequest), animated: true)
            }.store(in: &subscriptions)
        */
    }
}
