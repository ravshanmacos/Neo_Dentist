//
//  UIView+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit

extension UIView {
    
    func contentWidth() -> CGFloat {
        return screenWidth() - 32
    }
    
    func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }
    
    func screenHeight() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func removeAllSubviews() {
        subviews.forEach { view in
            view.removeFromSuperview()
        }
    }
    
    func configureWorkingDaysLabel(days: [String], start: String, end: String) -> String {
        var workingDaysString = ""
        days.forEach { day in
            workingDaysString.append(day)
            workingDaysString.append("/")
        }
        workingDaysString.append(" ")
        workingDaysString.append(start)
        workingDaysString.append(" - ")
        workingDaysString.append(end)
        return workingDaysString
    }
    
    func configureExperienceLabel(experience: Int) -> String {
        return "Стаж работы: \(experience) лет"
    }
    
    //MARK: Phone Number
    func extractFromFront(string: String, lenth: Int) -> String {
        return string.prefix(lenth).map{String($0)}.joined()
    }
    
    func extractEndFront(string: String, lenth: Int) -> String {
        return string.suffix(lenth).map{String($0)}.joined()
    }
    
    func getUserPhoneCode() -> (phoneCode: PhoneCode, number: String)? {
        guard let fullPhonNumber =
                UserDefaults.standard.string(forKey: UserDefaultsKeys.phoneNumber) else { return nil}
        
        if fullPhonNumber.starts(with: "+7") {
            if (fullPhonNumber.count - 2) == 10 {
                let phoneCode = ConstantDatas.countryPhoneCodes[1]
                let phoneNumber = extractEndFront(string: fullPhonNumber, lenth: 10)
                return (phoneCode, phoneNumber)
            } else if (fullPhonNumber.count - 2) == 11 {
                let phoneCode = ConstantDatas.countryPhoneCodes[2]
                let phoneNumber = extractEndFront(string: fullPhonNumber, lenth: 11)
                return (phoneCode, phoneNumber)
            }
        } else if fullPhonNumber.starts(with: "+998") {
            let phoneCode = ConstantDatas.countryPhoneCodes[0]
            let phoneNumber = extractEndFront(string: fullPhonNumber, lenth: 9)
            return (phoneCode, phoneNumber)
        } else {
            let phoneCode = ConstantDatas.countryPhoneCodes[1]
            let phoneNumber = extractEndFront(string: fullPhonNumber, lenth: 9)
            return (phoneCode, phoneNumber)
        }
        return nil
    }

}
