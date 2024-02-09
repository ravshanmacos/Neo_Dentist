//
//  SignUpRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import UIKit
import Combine

class SignUpRootView: ScrollableBaseView {
    
    //MARK: Properties
    let titleLabel: NDLabel = {
        let label = NDLabel()
        label.largeTitle()
        label.setTitle(text: "Регистрация ✍️")
        return label
    }()
    
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
    
    let loginField: NDInputField = {
       let field = NDInputField()
        field.configure(title: "Логин", placeholder: "Придумайте уникальный логин", description: "Укажите уникальный логин на латинице")
        return field
    }()
    
    let emailField: NDInputField = {
       let field = NDInputField()
        field.configure(title: "Почта", placeholder: "Введите вашу почту", description: "Укажите почту в формате example@mail.ru")
        return field
    }()
    
    let phoneNumberField: NDPhoneNumberField = {
       let field = NDPhoneNumberField()
        field.configure(title: "Номер телефона")
        return field
    }()
    
    let passwordField: NDInputField = {
       let field = NDInputField()
        field.inputField.enablePasswordToggle()
        field.configure(title: "Пароль", placeholder: "Создайте пароль", description: "Пароль должен содержать в себе одну заглавную букву и одну цифру")
        return field
    }()
    
    let confirmPasswordField: NDInputField = {
       let field = NDInputField()
        field.inputField.enablePasswordToggle()
        field.configure(title: "Повторите пароль", placeholder: "Повторите пароль")
        return field
    }()
    
    let nextButton: NDMainButton = {
        let button = NDMainButton()
        button.setTitle(text: "Далее")
        return button
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    
    private let viewModel: SignUpViewModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextfieldsToViewModel()
        bindViewsToViewModel()
        bindErrors()
    }
    
    override func setupUI() {
        super.setupUI()
        scrollViewContent.addSubviews(titleLabel, vStack)
        vStack.addArrangedSubviews(firstNameField, lastNameField, loginField, emailField, phoneNumberField, passwordField, confirmPasswordField, nextButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        firstNameField.inputField.delegate = self
        lastNameField.inputField.delegate = self
        loginField.inputField.delegate = self
        emailField.inputField.delegate = self
        passwordField.inputField.delegate = self
        confirmPasswordField.inputField.delegate = self
        
        nextButton.addTarget(viewModel, action: #selector(viewModel.nextButtonTapped), for: .touchUpInside)
    }
}

extension SignUpRootView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = R.color.gray_light()?.cgColor
        checkFields()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = R.color.blue_dark()?.cgColor
    }
    
    private func checkFields() {
        guard let text1 = firstNameField.inputField.text,
              let text2 = lastNameField.inputField.text,
              let text3 = loginField.inputField.text,
              let text4 = emailField.inputField.text,
              let text5 = passwordField.inputField.text,
              let text6 = confirmPasswordField.inputField.text
        else { return }
        
        let isFieldsEmpty = (text1.isEmpty || text2.isEmpty) || (text3.isEmpty || text4.isEmpty) || (text5.isEmpty  || text6.isEmpty)
        
        if  !isFieldsEmpty {
            viewModel.phoneNumber = phoneNumberField.countryPhoneCode + phoneNumberField.inputField.text!
            viewModel.enableNextButton()
        } else {
            viewModel.disableNextButton()
        }
    }
}

//MARK: Bind Textfields To ViewModel
private extension SignUpRootView {
    func bindTextfieldsToViewModel() {
        bindFirstNameField()
        bindLastNameField()
        bindLoginField()
        bindEmailField()
        bindPasswordField()
        bindConfirmPasswordField()
    }
    
    func bindFirstNameField() {
        firstNameField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.firstname, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindLastNameField() {
        lastNameField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.lastname, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindLoginField() {
        loginField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.login, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindEmailField() {
        emailField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindPasswordField() {
        passwordField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindConfirmPasswordField() {
        confirmPasswordField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &subscriptions)
    }
}

//MARK: Bind Views to ViewModel
private extension SignUpRootView {
    func bindViewsToViewModel() {
        bindViewModelToFirstnameField()
        bindViewModelToLastnameField()
        bindViewModelToLoginField()
        bindViewModelToEmailField()
        bindViewModelToPasswordField()
        bindViewModelToConfirmPasswordField()
        bindViewModelToNextButton()
    }
    
    func bindViewModelToFirstnameField() {
        viewModel
            .$firstnameEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: firstNameField.inputField)
            .store(in: &subscriptions)
    }
    func bindViewModelToLastnameField() {
        viewModel
            .$lastnameEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: lastNameField.inputField)
            .store(in: &subscriptions)
    }
    func bindViewModelToLoginField() {
        viewModel
            .$loginEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: loginField.inputField)
            .store(in: &subscriptions)
    }
    func bindViewModelToEmailField() {
        viewModel
            .$emailEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: emailField.inputField)
            .store(in: &subscriptions)
    }
    func bindViewModelToPasswordField() {
        viewModel
            .$passwordEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: passwordField.inputField)
            .store(in: &subscriptions)
    }
    func bindViewModelToConfirmPasswordField() {
        viewModel
            .$confiPasswordEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: confirmPasswordField.inputField)
            .store(in: &subscriptions)
    }
    func bindViewModelToNextButton() {
        viewModel
            .$nextButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: nextButton)
            .store(in: &subscriptions)
    }
}

//MARK: BindErrors
private extension SignUpRootView {
    func bindErrors() {
        bindInvalidEmail()
        bindInvalidPassword()
        bindPasswordsDidNotMatch()
    }
    
    func bindInvalidEmail() {
        viewModel
            .$invalidEmail
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isInvalid in
                guard let self, isInvalid else { return }
                emailField.enableRedBorders()
                emailField.inputField.text = ""
                emailField.inputField.placeholder = InputFieldErrors.invalidEmail.rawValue
            }.store(in: &subscriptions)
    }
    
    func bindInvalidPassword() {
        viewModel
            .$invalidPassword
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isInvalid in
                guard let self, isInvalid else { return }
                passwordField.enableRedBorders()
                emailField.inputField.text = ""
                passwordField.inputField.placeholder = InputFieldErrors.invalidPassword.rawValue
            }.store(in: &subscriptions)
    }
    
    func bindPasswordsDidNotMatch() {
        viewModel
            .$passwordsDidNotMatch
            .receive(on: DispatchQueue.main)
            .sink {[weak self] isInvalid in
                guard let self, isInvalid else { return }
                passwordField.enableRedBorders()
                confirmPasswordField.enableRedBorders()
                passwordField.inputField.text = ""
                confirmPasswordField.inputField.text = ""
                passwordField.inputField.placeholder = InputFieldErrors.invalidPassword.rawValue
                confirmPasswordField.inputField.placeholder = InputFieldErrors.invalidPassword.rawValue
            }.store(in: &subscriptions)
    }
}
