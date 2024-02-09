//
//  UserDefaults+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 23/12/23.
//

import Foundation

extension UserDefaults {
    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        self.set(value, forKey: UserDefaultsKeys.isLoggedIn)
    }
    func setLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn)
    }
}
