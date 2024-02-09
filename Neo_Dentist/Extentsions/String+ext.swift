//
//  String+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        return self.count >= 8
    }
    
    func extractHourAndMinutes() -> (hour: Int?, minute: Int?) {
        var splittedTimeString = self.split(separator: ":")
        let hourString = splittedTimeString[0].map{ String($0) }.joined()
        let minutesString = splittedTimeString[1].map{ String($0) }.joined()

        let hourInt = Int(hourString)
        let minutesInt = Int(minutesString)
        return (hourInt, minutesInt)
    }
    
    func removeSpacesFromString() -> String {
        return self.split(separator: " ").joined()
    }
}
