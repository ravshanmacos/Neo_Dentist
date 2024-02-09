//
//  FilterDoctorsViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import Foundation
import UIKit

class FilterDoctorsViewModel {
    
    @Published private(set) var openSpecializationView = false
    @Published private(set) var openExperienceView = false
    
    @Published private(set) var updateOptions = false
    var specializationOptions: [SpecializationModel] = []
    
    init() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateSpecializationOptions), name: NSNotification.Name(rawValue: "UpdateSpecialization"), object: nil)
        
    }
    
    @objc func removeButtonTapped(_ sender: UIButton) {
        specializationOptions.remove(at: sender.tag)
        updateOptions = true
        
        let optionsData: [String: [SpecializationModel]] = ["optionsData": specializationOptions]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateDoctors"), object: nil, userInfo: optionsData)
    }
    
    @objc func updateSpecializationOptions(_ notification: NSNotification) {
        if let optionsData = notification.userInfo?["optionsData"] as? [SpecializationModel] {
            specializationOptions = optionsData
            updateOptions = true
        }
    }
    
    @objc func specializationButtonTapped() {
        openSpecializationView = true
    }
    
    @objc func experienceButtonTapped() {
        openExperienceView = true
    }
    
}
