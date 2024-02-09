//
//  SignInRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit
import Combine

class SignInRootView: BaseView {
    
    //MARK: Properties
    private let baseFormView: NDBaseFormView = {
       let formView = NDBaseFormView(isMiddleButtonEnabled: true)
        formView.titleLabel.setTitle(text: "Приветствуем! 👋")
        formView.firstInputField.configure(title: "Логин", placeholder: "Введите ваш логин")
        formView.secondInputField.configure(title: "Пароль", placeholder: "Введите ваш пароль")
        formView.secondInputField.inputField.enablePasswordToggle()
        formView.middleButton.setTitle(text: "Не помните пароль?")
        formView.mainButton.setTitle(text: "Войти")
        return formView
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    private let registerButtonLabel: NDLabel = {
        let label = NDLabel()
        label.setTitle(text: "Впервые у нас?")
        label.smallTitle()
        return label
    }()
    
    private let registerButton: NDLinkButton = {
        let button = NDLinkButton()
        button.setTitle(text: "Зарегистрироваться")
        return button
    }()
    
    private let viewModel: SignInViewModel
    var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: SignInViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextFieldsToViewModel()
        bindViewModelToViews()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(baseFormView, vStack)
        vStack.addArrangedSubviews(registerButtonLabel, registerButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        baseFormView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalTo(baseFormView.snp.leading)
            make.trailing.equalTo(baseFormView.snp.trailing)
        }
        
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        baseFormView.mainButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        baseFormView.middleButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }
}
//MARK: Actions
@objc private extension SignInRootView {
    func signInButtonTapped() {
        viewModel.signInUser()
    }
    
    func registerButtonTapped() {
        viewModel.navigateToSignUp()
    }
    
    func forgotPasswordButtonTapped() {
        viewModel.navigateToPasswordRecovery()
    }
}

//MARK: Binding TextFields To ViewModel
private extension SignInRootView {
    func bindTextFieldsToViewModel() {
        bindEmailField()
        bindPasswordField()
    }
    
    func bindEmailField() {
        baseFormView
            .firstInputField
            .inputField
            .publisher(for: \.text)
            .map{ $0 ?? "" }
            .assign(to: \.login, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindPasswordField() {
        baseFormView
            .secondInputField
            .inputField
            .publisher(for: \.text)
            .map{$0 ?? ""}
            .assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
}

private extension SignInRootView {
    func bindViewModelToViews() {
        bindViewModelToEmailField()
        bindViewModelToPasswordField()
        bindViewModelToSignInButton()
        bindViewModelToSignInActivityIndicator()
        bindViewModelToSignInError()
    }
    
    func bindViewModelToEmailField() {
        let emailfield = baseFormView.firstInputField.inputField
        viewModel
            .$loginInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: emailfield)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToPasswordField() {
        let passwordField = baseFormView.secondInputField.inputField
        viewModel
            .$passwordInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: passwordField)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToSignInButton() {
        let signInButton = baseFormView.mainButton
        viewModel
            .$signInButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: signInButton)
            .store(in: &subscriptions)
    }
    
    func bindViewModelToSignInActivityIndicator() {
        viewModel
            .$signInActivityIndicatorEnabled
            .receive(on: DispatchQueue.main)
            .sink {[weak self] animating in
                guard let self else { return }
                switch animating {
                case true: baseFormView.loadingView.startAnimating()
                case false: baseFormView.loadingView.stopAnimating()
                }
            }
            .store(in: &subscriptions)
    }
    
    func bindViewModelToSignInError() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: baseFormView.enableErrorMode(_:))
            .store(in: &subscriptions)
    }
}
