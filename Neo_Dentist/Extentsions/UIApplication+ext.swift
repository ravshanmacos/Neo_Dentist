//
//  UIApplication+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 23/12/23.
//

import UIKit

extension UIApplication {
    func isAuthorised() -> Bool {
        return (KeychainNeoDentist.getValue(key: KeychainConstants.accessToken) != nil)
    }
}
