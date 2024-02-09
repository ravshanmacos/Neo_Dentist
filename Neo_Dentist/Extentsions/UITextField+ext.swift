//
//  UITextField+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import UIKit

extension UITextField {
    func makeConfirmCodeField() {
        self.keyboardType = .numberPad
        self.placeholder = "0"
        self.font = .systemFont(ofSize: 32, weight: .medium)
        self.layer.borderWidth = 1
        self.textAlignment = .center
        self.layer.cornerRadius = 10
        self.layer.borderColor = R.color.gray_light()?.cgColor
    }
    
    fileprivate func setPasswordToggleImage(_ button: UIButton) {
        if(isSecureTextEntry){
            button.setImage(R.image.eye_open_icon(), for: .normal)
        }else{
            button.setImage(R.image.eye_closed_icon(), for: .normal)
        }
    }

    func enablePasswordToggle(){
        let button = UIButton(type: .custom)
        setPasswordToggleImage(button)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        button.frame = CGRect(x: CGFloat(self.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.togglePasswordView), for: .touchUpInside)
        self.rightView = button
        self.rightViewMode = .always
    }
    @IBAction func togglePasswordView(_ sender: Any) {
        self.isSecureTextEntry = !self.isSecureTextEntry
        setPasswordToggleImage(sender as! UIButton)
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
