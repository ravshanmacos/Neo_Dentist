//
//  EditUserProfileViewModel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import Foundation

class EditUserProfileViewModel {
    @Published private(set) var openDeleteActionPanModal = false
    @Published private(set) var openRootView = false
    
    private let userNetworkService: UserNetworkService
    
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var phoneNumberCode: String = ""
    
    //MARK: Methods
    
    init(userNetworkService: UserNetworkService) {
        self.userNetworkService = userNetworkService
        self.firstName = UserDefaults.standard.string(forKey: UserDefaultsKeys.firstName) ?? ""
        self.lastName = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastName) ?? ""
        self.email = UserDefaults.standard.string(forKey: UserDefaultsKeys.email) ?? ""
        self.phoneNumber = UserDefaults.standard.string(forKey: UserDefaultsKeys.phoneNumber) ?? ""
    }
    
    @objc func deleteAccountTapped() {
        openDeleteActionPanModal = true
    }
    
    func saveChangesButtonTapped() {
        guard firstName != "",
              lastName != "",
              email != "",
              phoneNumber != "" else { return }
        let makePhoneNumber = phoneNumberCode + phoneNumber.removeSpacesFromString()
        let request = UpdateUserProfileRequest(firstName: firstName, lastName: lastName, email: email, phoneNumber: makePhoneNumber)
        update(request: request)
        
    }
}

extension EditUserProfileViewModel {
    func update(request: UpdateUserProfileRequest) {
        userNetworkService.updateUserProfile(request: request) {[weak self] result in
            guard let self else { return }
            switch result {
            case .success(let userInfo):
                UserDefaults.standard.setValue(userInfo.firstName, forKey: UserDefaultsKeys.firstName)
                UserDefaults.standard.setValue(userInfo.lastName, forKey: UserDefaultsKeys.lastName)
                UserDefaults.standard.setValue(userInfo.email, forKey: UserDefaultsKeys.email)
                UserDefaults.standard.setValue(userInfo.phoneNumber, forKey: UserDefaultsKeys.phoneNumber)
                print("successfully updated")
                openRootView = true
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func deleteUserProfile() {
        userNetworkService.deleteUserProfile { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}
