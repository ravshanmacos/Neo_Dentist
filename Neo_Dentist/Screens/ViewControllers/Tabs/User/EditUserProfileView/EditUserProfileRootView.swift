//
//  EditUserProfileRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit

class EditUserProfileRootView: BaseView {
    let firstNameField: NDInputField = {
       let field = NDInputField()
        field.configure(title: "Имя", placeholder: "Введите ваше имя")
        return field
    }()
    
    let lastNameField: NDInputField = {
       let field = NDInputField()
        field.configure(title: "Фамилия", placeholder: "Введите вашу фамилию")
        return field
    }()
    
    let emailField: NDInputField = {
       let field = NDInputField()
        field.configure(title: "Почта", placeholder: "Введите вашу Почта")
        return field
    }()
    
    let phoneNumberField: NDPhoneNumberField = {
       let field = NDPhoneNumberField()
        field.configure(title: "Номер телефона")
        return field
    }()
    
    let deleteAccountButton = UserProfileRootView
        .makeFeaturedButton(title: "Удалить аккаунт", color: R.color.red_error())
    
    let saveChangesButton: NDMainButton = {
        let button = NDMainButton()
        button.isEnabled  = true
        button.setTitle(text: "Сохранить изменения")
        return button
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    private let viewModel: EditUserProfileViewModel
    
    init(frame: CGRect = .zero, viewModel: EditUserProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(vStack, deleteAccountButton, saveChangesButton)
        vStack.addArrangedSubviews(firstNameField, lastNameField, emailField, phoneNumberField)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        deleteAccountButton.snp.makeConstraints { make in
            make.top.equalTo(vStack.snp.bottom)
            make.leading.equalToSuperview()
            make.height.equalTo(48)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        firstNameField.inputField.text = viewModel.firstName
        lastNameField.inputField.text = viewModel.lastName
        emailField.inputField.text = viewModel.email
        if let (phoneCode, phoneNumber) = getUserPhoneCode() {
            self.phoneNumberField.countryPhoneCode = phoneCode.code
            self.phoneNumberField.selectedCountryImage = phoneCode.image
            self.phoneNumberField.textPlaceHolder = phoneCode.textPlaceHolder
            self.phoneNumberField.inputField.text = phoneNumber
            self.phoneNumberField.configureUI()
        }
        
        deleteAccountButton.addTarget(viewModel, action: #selector(viewModel.deleteAccountTapped), for: .touchUpInside)
        saveChangesButton.addTarget(self, action: #selector(saveChangesButtonTapped), for: .touchUpInside)
        
    }
    
    @objc func saveChangesButtonTapped() {
        viewModel.firstName = firstNameField.inputField.text ?? ""
        viewModel.lastName = lastNameField.inputField.text ?? ""
        viewModel.email = emailField.inputField.text ?? ""
        viewModel.phoneNumber = phoneNumberField.inputField.text ?? ""
        viewModel.phoneNumberCode = phoneNumberField.countryPhoneCode
        viewModel.saveChangesButtonTapped()
    }
}

