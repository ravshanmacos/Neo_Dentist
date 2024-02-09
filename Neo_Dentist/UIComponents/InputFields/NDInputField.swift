//
//  NDInputField.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit
import SnapKit

class NDInputField: BaseView {

    //MARK: Properties
    let titleLabel: NDLabel = {
        let label = NDLabel()
        label.smallSemiboldTitle()
        label.textAlignment = .left
        label.textColor = R.color.gray()
        return label
    }()
    
    let inputField: UITextField = {
       let textfield = UITextField()
        textfield.font = .systemFont(ofSize: 14, weight: .medium)
        textfield.layer.cornerRadius = 25
        textfield.layer.borderWidth = 1
        textfield.setLeftPaddingPoints(16)
        textfield.layer.borderColor = R.color.gray_light()?.cgColor
        return textfield
    }()
    
    let descriptionLabel: NDLabel = {
        let label = NDLabel()
        label.textAlignment = .left
        label.textColor = R.color.gray_light()
        return label
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: Methods
    
    override func setupUI() {
        super.setupUI()
        addSubviews(vStack)
        vStack.addArrangedSubviews(titleLabel, inputField)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        inputField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
    
    func configure(title: String, placeholder: String, description: String = "") {
        titleLabel.text = title
        inputField.placeholder = placeholder
        if !description.isEmpty {
            vStack.addArrangedSubview(descriptionLabel)
            descriptionLabel.makeItalic(text: description)
        }
    }
    
}

extension NDInputField {
    func enableRedBorders() {
        inputField.layer.borderColor = R.color.red_error()?.cgColor
    }
}
