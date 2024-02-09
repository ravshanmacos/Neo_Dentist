//
//  SpecializationViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import Foundation
import Combine

class SpecializationViewModel {
    @Published var options: [SpecializationModel] = SpecializationModel.mockSpecializationData()
    
    @objc func saveButtonTapped() {
        options = options.filter{$0.isActive}
        
        let optionsData: [String: [SpecializationModel]] = ["optionsData": options]
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "UpdateSpecialization"), object: nil, userInfo: optionsData)
    }
    
}
