//
//  confirmCodeView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import UIKit

class ConfirmCodeView: BaseView {
    private let fieldCode1: UITextField = {
        let textfield = UITextField()
        textfield.makeConfirmCodeField()
        return textfield
    }()
    
    private let fieldCode2: UITextField = {
        let textfield = UITextField()
        textfield.makeConfirmCodeField()
        return textfield
    }()
    
    private let fieldCode3: UITextField = {
        let textfield = UITextField()
        textfield.makeConfirmCodeField()
        return textfield
    }()
    
    private let fieldCode4: UITextField = {
        let textfield = UITextField()
        textfield.makeConfirmCodeField()
        return textfield
    }()
    
    private let hStack = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    @Published var code: String = ""
    
    override func setupUI() {
        super.setupUI()
        addSubviews(hStack)
        hStack.addArrangedSubviews(fieldCode1, fieldCode2, fieldCode3, fieldCode4)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        fieldCode1.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
        fieldCode2.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
        fieldCode3.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
        fieldCode4.addTarget(self, action: #selector(valueDidChange), for: .editingChanged)
    }
    
    @IBAction func valueDidChange(_ textfield: UITextField) {
        guard let text = textfield.text else { return }
        let maxLength = 1
        switch textfield {
        case fieldCode1 where text.count == maxLength:
            fieldCode2.becomeFirstResponder()
        case fieldCode2 where text.count == maxLength:
            fieldCode3.becomeFirstResponder()
        case fieldCode3 where text.count == maxLength:
            fieldCode4.becomeFirstResponder()
        case fieldCode4 where text.count == maxLength:
            checkConfirmationCode()
        default:
            break
        }
    }
    
    private func checkConfirmationCode() {
        guard let code1 = fieldCode1.text,
              let code2 = fieldCode2.text,
              let code3 = fieldCode3.text,
              let code4 = fieldCode4.text
        else { return }
        code = code1 + code2 + code3 + code4
    }
}

