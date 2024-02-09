//
//  CheckViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit
import Combine

class CheckViewController: BaseViewController {
    private let rootView: CheckRootView
    private let appoinmentResponse: AppointmentsResponse
    private let calendarConfigure = CalendarConfigure.shared
    
    init( appoinmentResponse: AppointmentsResponse) {
        self.appoinmentResponse = appoinmentResponse
        self.rootView = CheckRootView()
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = R.color.blue_dark()
        print(appoinmentResponse)
       configureRootView()
        
    }
    
    private func configureRootView() {
        rootView.checkView.firstnameFieldView.rightSideLabel.text = appoinmentResponse.patientFirstName
        rootView.checkView.lastnameFieldView.rightSideLabel.text = appoinmentResponse.patientLastName
        rootView.checkView.phoneFieldView.rightSideLabel.text = appoinmentResponse.patientPhoneNumber
        rootView.checkView.doctorFieldView.rightSideLabel.text = appoinmentResponse.doctor.fullName
        rootView.checkView.serviceFieldView.rightSideLabel.text = appoinmentResponse.service.name
        rootView.checkView.dateFieldView.rightSideLabel.text = calendarConfigure.decodeAppointmentTimeSlot(dateString: appoinmentResponse.appointmentTime, style: .original)
        rootView.checkView.addressFieldView.rightSideLabel.text = appoinmentResponse.address
        rootView.goBackMainButton.addTarget(self, action: #selector(goBackMainTapped), for: .touchUpInside)
    }
}

@objc extension CheckViewController {
    func goBackMainTapped() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "clearAppointmentInfo"), object: nil)
        navigationController?.popToRootViewController(animated: true)
    }
}
