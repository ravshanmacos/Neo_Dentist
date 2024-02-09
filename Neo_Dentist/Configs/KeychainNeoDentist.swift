//
//  KeychainNeoDentist.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 22/12/23.
//

import Foundation
import Valet

enum UserDefaultsKeys{
    static let email =  "email"
    static let userID = "userID"
    static let phoneNumber = "phoneNumber"
    static let phoneNumberCodeID = "phoneNumberCodeID"
    
    static let confirmEmail =  "confirmEmail"
    static let confirmPhone = "confirmPhone"
    static let firstName = "firstName"
    static let lastName = "lastName"
    static let profilePhoto = "profilePhoto"
    static let username = "username"
    static let isLoggedIn = "isLoggedIn"
    static let userDetails = "userDetails"
}
enum KeychainConstants{
    static let accessToken = "B&`Cw6{8?PjSZv_C"
    static let refreshToken = "B&`Q-B,4yvtv_C"
    static let userID = "Xr#BJ,Q-B,4yvt{f"
}

class KeychainNeoDentist {
    static let valet = Valet.valet(with: Identifier(nonEmpty: "NeoDentistData")!, accessibility: .whenUnlockedThisDeviceOnly)
    
    static func setToken(value: String, key: String) {
        do {
            try valet.setString(value, forKey: key)
        } catch {
            print("Error in saving keychain \(error)")
        }
    }
    
    static func getValue(key: String) -> String? {
        var string: String? = nil
        do {
            string = try valet.string(forKey: key)
        } catch {
            print("Error in getting from keychain \(error)")
        }
        return string
    }
    
    static func removeAll() {
        do {
            try valet.removeAllObjects()
        } catch {
            print("Error in removing keys  \(error)")
        }
    }
    
    static func removeKey(key:String){
        do {
            try valet.removeObject(forKey: key)
        } catch{
            print("Error in removing specific key \(error)")
        }
    }
}
