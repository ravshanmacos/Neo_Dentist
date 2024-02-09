//
//  ProfileFormRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit
import Combine

class UserInfoRootView: BaseView {
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
    let phoneNumberField: NDPhoneNumberField = {
       let field = NDPhoneNumberField()
        field.configure(title: "Номер телефона")
        return field
    }()
    let nextButton: NDMainButton = {
        let button = NDMainButton()
        button.isEnabled  = true
        button.setTitle(text: "Записаться на прием")
        return button
    }()
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        return stack
    }()
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: UserInfoViewModel
    
    init(frame: CGRect = .zero, viewModel: UserInfoViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextfieldsToViewModel()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(vStack, nextButton)
        vStack.addArrangedSubviews(firstNameField, lastNameField, phoneNumberField)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        self.firstNameField.inputField.text = viewModel.firstName
        self.lastNameField.inputField.text = viewModel.lastName
        
        if let (phoneCode, phoneNumber) = getUserPhoneCode() {
            self.phoneNumberField.countryPhoneCode = phoneCode.code
            self.phoneNumberField.selectedCountryImage = phoneCode.image
            self.phoneNumberField.textPlaceHolder = phoneCode.textPlaceHolder
            self.phoneNumberField.inputField.text = phoneNumber
            self.phoneNumberField.configureUI()
        }
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
    }
    
    @objc func nextButtonTapped() {
        viewModel.phoneNumber = phoneNumberField.inputField.text ?? ""
        viewModel.phoneNumberCode = phoneNumberField.countryPhoneCode
        viewModel.nextButtonTapped()
    }
}

extension UserInfoRootView {
    func bindTextfieldsToViewModel() {
        bindFirstNameField()
        bindLastNameField()
    }
    
    func bindFirstNameField() {
        firstNameField
            .inputField
            .publisher(for: \.text)
            .map{ $0 ?? "" }
            .assign(to: \.firstName, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindLastNameField() {
        lastNameField
            .inputField
            .publisher(for: \.text)
            .map{ $0 ?? "" }
            .assign(to: \.lastName, on: viewModel)
            .store(in: &subscriptions)
    }
}
