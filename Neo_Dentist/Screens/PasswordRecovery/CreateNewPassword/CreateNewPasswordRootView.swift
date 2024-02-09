//
//  CreateNewPasswordRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import Foundation
import Combine

class CreateNewPasswordRootView: BaseView {
    
    let baseFormView: NDBaseFormView = {
        let formView = NDBaseFormView()
        formView.titleLabel.setTitle(text: "Создание пароля 🔒")
        formView.firstInputField.configure(title: "Новый пароль",
                                           placeholder: "Введите ваш новый пароль",
                                           description: "Пароль должен содержать в себе одну заглавную букву и одну цифру")
        formView.firstInputField.inputField.enablePasswordToggle()
        formView.secondInputField.configure(title: "Повторите пароль", placeholder: "Повторите ваш пароль")
        formView.secondInputField.inputField.enablePasswordToggle()
        formView.mainButton.setTitle(text: "Создать пароль")
        return formView
    }()
    
    private let viewModel: CreateNewPasswordViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: CreateNewPasswordViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextFieldsToViewModel()
        bindViewModelToViews()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(baseFormView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        baseFormView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        baseFormView.mainButton.addTarget(viewModel, action: #selector(viewModel.createNewPasswordButtonTapped(_:)), for: .touchUpInside)
    }
}

//MARK: Binding TextFields To ViewModel
private extension CreateNewPasswordRootView {
    func bindTextFieldsToViewModel() {
        bindPasswordField()
        bindConfirmPasswordField()
        bindIsFieldsEmptyToView()
    }
    
    func bindPasswordField() {
        baseFormView
            .firstInputField
            .inputField
            .publisher(for: \.text)
            .map{ $0 ?? "" }
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindConfirmPasswordField() {
        baseFormView
            .secondInputField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.confirmPassword, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindIsFieldsEmptyToView() {
        baseFormView
            .$isFieldsEmpty
            .sink {[weak self] isFieldsEmpty in
                guard let self else { return }
                viewModel.changeButtonState(isFieldsEmpty)
            }.store(in: &subscriptions)
    }
}

//MARK: bindViewModelToViews
private extension CreateNewPasswordRootView {
    func bindViewModelToViews() {
        bindViewModelpasswordField()
        bindViewModelToPasswordField()
        bindViewModelToCreatePasswordButton()
        bindViewModelToError()
    }
    
    func bindViewModelpasswordField() {
        let passwordField = baseFormView.firstInputField.inputField
        viewModel
            .$passwordInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: passwordField)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToPasswordField() {
        let confirmPasswordField = baseFormView.secondInputField.inputField
        viewModel
            .$passwordConfirmEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: confirmPasswordField)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToCreatePasswordButton() {
        viewModel
            .$nextButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: baseFormView.mainButton)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToError() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: baseFormView.enableErrorMode(_:))
            .store(in: &subscriptions)
    }
}
