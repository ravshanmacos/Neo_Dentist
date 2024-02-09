//
//  NDBaseFormView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import UIKit

class NDBaseFormView: BaseView {
    //MARK: Properties
    
    let titleLabel: NDLabel = {
        let label = NDLabel()
        label.largeTitle()
        return label
    }()
    let errorLabel = NDLabel()
    let firstInputField = NDInputField()
    let secondInputField = NDInputField()
    let middleButton = NDLinkButton()
    let mainButton = NDMainButton()
    
    let loadingView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let isMiddleButtonEnabled: Bool
    @Published var showErrorLabel = false
    @Published private(set) var isFieldsEmpty = true
    
    //MARK: Methods
    
    init(frame: CGRect = .zero, isMiddleButtonEnabled: Bool = false) {
        self.isMiddleButtonEnabled = isMiddleButtonEnabled
        super.init(frame: frame)
    }
    
    override func setupUI() {
        super.setupUI()
        addSubviews(loadingView, titleLabel, errorLabel, firstInputField, secondInputField)
        if isMiddleButtonEnabled {
            addSubviews(middleButton, mainButton)
        } else {
            addSubviews(mainButton)
        }
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        loadingView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(19)
            make.leading.equalToSuperview()
        }
        
        firstInputField.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        secondInputField.snp.makeConstraints { make in
            make.top.equalTo(firstInputField.snp.bottom).offset(16)
            make.leading.equalTo(firstInputField.snp.leading)
            make.trailing.equalTo(firstInputField.snp.trailing)
        }
        
        mainButton.snp.makeConstraints { make in
            make.leading.equalTo(firstInputField.snp.leading)
            make.trailing.equalTo(firstInputField.snp.trailing)
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
        
        if isMiddleButtonEnabled {
            middleButton.snp.makeConstraints { make in
                make.top.equalTo(secondInputField.snp.bottom).offset(16)
                make.trailing.equalTo(secondInputField.snp.trailing)
            }
            
            mainButton.snp.makeConstraints { make in
                make.top.equalTo(middleButton.snp.bottom).offset(16)
            }
        }
    }
    
    override func configureUI() {
        super.configureUI()
        firstInputField.inputField.delegate = self
        secondInputField.inputField.delegate = self
    }
    
    func enableErrorMode(_ errorMessage: ErrorMessage) {
        errorLabel.setTitle(text: errorMessage.message)
        errorLabel.enableErrorLabel()
        firstInputField.enableRedBorders()
        secondInputField.enableRedBorders()
    }
}

extension NDBaseFormView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = R.color.gray_light()?.cgColor
        checkFields()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = R.color.blue_dark()?.cgColor
    }
    
    private func checkFields() {
        guard let text1 = secondInputField.inputField.text,
              let text2 = firstInputField.inputField.text else { return }
        
        isFieldsEmpty = text1.isEmpty || text2.isEmpty
        
    }
}
