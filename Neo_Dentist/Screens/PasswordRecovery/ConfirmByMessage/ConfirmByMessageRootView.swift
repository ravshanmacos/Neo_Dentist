//
//  ConfirmByMessageRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import UIKit
import Combine

class ConfirmByMessageRootView: BaseView {
    
    private let titleLabel: NDLabel = {
        let label = NDLabel()
        label.largeTitle()
        label.setTitle(text: "Восстановление пароля 🔒")
        return label
    }()
    
    private let descriptionLabel: NDLabel = {
        let label = NDLabel()
        label.smallTitle()
        return label
    }()
    let errorLabel = NDLabel()
    private let confirmCodeView = ConfirmCodeView()
    private let remainingTimeLimitView = RemainingTimeLimitView()
    private let confirmButton: NDMainButton = {
        let button = NDMainButton()
        button.setTitle(text: "Подтвердить")
        return button
    }()
    
    private var userEmail: String? {
        didSet {
            guard let userEmail else { return }
            let descriptionTextPart_1 = NSMutableAttributedString(string: "На вашу почту ")
            let descriptionTextPart_2 = NSMutableAttributedString(string: " было отправлено письмо с кодом для восстановления пароля. \n\n Пожалуйста, введите полученный код ниже.")
            let boldText = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .bold)]
            let boldAttributedString = NSMutableAttributedString(string: userEmail, attributes: boldText)
            descriptionTextPart_1.append(boldAttributedString)
            descriptionTextPart_1.append(descriptionTextPart_2)
            descriptionLabel.attributedText = descriptionTextPart_1
        }
    }
    private var subscriptions = Set<AnyCancellable>()
    let viewModel: ConfirmByMessageViewModel
    
    init(frame: CGRect = .zero, viewModel: ConfirmByMessageViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewToTimerManager()
        bindViewModeltoView()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(titleLabel, errorLabel, descriptionLabel, confirmCodeView, remainingTimeLimitView, confirmButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.leading.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(24)
            make.left.right.equalToSuperview()
        }
        
        confirmCodeView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(48)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(86)
        }
        remainingTimeLimitView.snp.makeConstraints { make in
            make.top.equalTo(confirmCodeView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        //userEmail = viewModel.request.email
        let gestureRecognizer = UITapGestureRecognizer(target: viewModel, action: #selector(viewModel.sendVerificationCodeTapped))
        remainingTimeLimitView.addGestureRecognizer(gestureRecognizer)
        confirmButton.addTarget(viewModel, action: #selector(viewModel.verifyCode(_:)), for: .touchUpInside)
    }
    
    func enableErrorMode(_ errorMessage: ErrorMessage) {
        errorLabel.setTitle(text: errorMessage.message)
        errorLabel.enableErrorLabel()
    }
    
}

//MARK: bindViewToTimerManager
private extension ConfirmByMessageRootView {
    func bindViewToTimerManager() {
        bindViewToTimerSeconds()
    }
    
    func bindViewToTimerSeconds() {
        viewModel
            .$seconds
            .receive(on: DispatchQueue.main)
            .sink {[weak self] second in
                guard let self else { return }
                remainingTimeLimitView.remainingTimeLabel.text = String(second)
            }.store(in: &subscriptions)
            
    }
}

//MARK: bindViewModeltoView

private extension ConfirmByMessageRootView {
    func bindViewModeltoView() {
        bindViewModelToSendVerification()
        bindViewToConfirmCodeView()
        bindViewModelToError()
        bindViewModelToConfirmButton()
    }
    
    func bindViewModelToSendVerification() {
        viewModel
            .$sendVerificationEnabled
            .receive(on: DispatchQueue.main)
            .sink {[weak self] sendVerification in
                guard let self else { return }
                switch sendVerification {
                case true:
                    remainingTimeLimitView.enableSendConfirmationButton()
                case false: 
                    remainingTimeLimitView.disableSendConfirmationButton()
                }
            }.store(in: &subscriptions)
    }
    
    func bindViewToConfirmCodeView() {
        confirmCodeView
            .$code
            .sink(receiveValue: {[weak self] code in
                guard let self, !code.isEmpty else { return }
                viewModel.setConfirmCode(code)
            })
            .store(in: &subscriptions)
    }
    
    func bindViewModelToError() {
        viewModel
            .errorMessagePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: enableErrorMode(_:))
            .store(in: &subscriptions)
    }
    
    func bindViewModelToConfirmButton() {
        viewModel
            .$confirmButtonEnabled
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: confirmButton)
            .store(in: &subscriptions)
    }
}
