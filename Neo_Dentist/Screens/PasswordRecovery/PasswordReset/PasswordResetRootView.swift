//
//  RecoveryRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import UIKit
import Combine

class PasswordResetRootView: BaseView {
    
    //MARK: Properties
    private let baseFormView: NDBaseFormView = {
       let formView = NDBaseFormView()
        formView.titleLabel.setTitle(text: "Восстановление пароля 🔒")
        formView.firstInputField.configure(title: "Логин", placeholder: "Введите ваш логин")
        formView.secondInputField.configure(title: "Почта", placeholder: "Введите вашу почту")
        formView.mainButton.setTitle(text: "Далее")
        return formView
    }()
    
    private let viewModel: PasswordResetViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: PasswordResetViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindTextFieldsToViewModel()
        bindViewModelToViews()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(baseFormView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        baseFormView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        baseFormView.mainButton.addTarget(viewModel, action: #selector(viewModel.verifyButtonTapped(_:)), for: .touchUpInside)
    }
}

//MARK: bindTextFieldsToViewModel

private extension PasswordResetRootView {
    func bindTextFieldsToViewModel() {
        bindLoginField()
        bindEmailField()
    }
    
    func bindLoginField() {
        baseFormView
            .firstInputField
            .inputField
            .publisher(for: \.text)
            .map{ $0 ?? "" }
            .assign(to: \.login, on: viewModel)
            .store(in: &subscriptions)
    }
    
    func bindEmailField() {
        baseFormView
            .secondInputField
            .inputField
            .publisher(for: \.text)
            .map{ $0 ?? "" }
            .assign(to: \.email, on: viewModel)
            .store(in: &subscriptions)
    }
}

//MARK: bindViewModelToViews

private extension PasswordResetRootView {
    func bindViewModelToViews() {
        bindViewModelToLoginField()
        bindViewModelToEmailField()
        bindViewModelToNextButton()
        bindViewModelToError()
    }
    
    func bindViewModelToLoginField() {
        let loginfield = baseFormView.firstInputField.inputField
        viewModel
            .$loginInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: loginfield)
            .store(in: &subscriptions)
    }
    func bindViewModelToEmailField() {
        let emailfield = baseFormView.secondInputField.inputField
        viewModel
            .$emailInputEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: emailfield)
            .store(in: &subscriptions)
    }
    func bindViewModelToNextButton() {
        let nextButton = baseFormView.mainButton
        viewModel
            .$nextButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: nextButton)
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
