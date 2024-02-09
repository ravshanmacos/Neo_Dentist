//
//  NDPhoneNumberField.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import UIKit
import AnyFormatKit

class NDPhoneNumberField: BaseView {
    //MARK: Properties
    let titleLabel: NDLabel = {
        let label = NDLabel()
        label.smallSemiboldTitle()
        label.textAlignment = .left
        label.textColor = R.color.gray()
        return label
    }()
    
    let selectedImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let selectMenuButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(R.color.dark(), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.setImage(R.image.arrowLeft(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        return button
    }()
    
    let inputField: UITextField = {
       let textfield = UITextField()
        textfield.keyboardType = .numberPad
        textfield.textContentType = .telephoneNumber
        textfield.font = .systemFont(ofSize: 14, weight: .medium)
        return textfield
    }()
    
    private let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 5
        stack.distribution = .fill
        stack.layer.cornerRadius = 25
        stack.layer.borderWidth = 1
        stack.layer.borderColor = R.color.gray_light()?.cgColor
        stack.layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    var formatType = "### ### ###"
    private let sharedInstance = TextFieldInputController()
    
    var countryPhoneCode = ConstantDatas.countryPhoneCodes[0].code
    var selectedCountryImage = ConstantDatas.countryPhoneCodes[0].image
    var textPlaceHolder = ConstantDatas.countryPhoneCodes[0].textPlaceHolder
    
    //MARK: methods
    override func setupUI() {
        super.setupUI()
        addSubviews(vStack)
        vStack.addArrangedSubviews(titleLabel, hStack)
        hStack.addArrangedSubviews(selectedImageView, selectMenuButton, inputField)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        hStack.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        selectedImageView.snp.makeConstraints { make in
            make.width.equalTo(24)
        }
        
        selectMenuButton.snp.makeConstraints { make in
            make.width.equalTo(65)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        
        inputField.delegate = sharedInstance
        selectMenuButton.setTitle(countryPhoneCode, for: .normal)
        selectedImageView.image = selectedCountryImage
        configureTextfield(with: textPlaceHolder, formatType: formatType)
        
        let handleButtonTap = {[weak self] (action: UIAction) in
            guard let self else { return }
            inputField.text = ""
            countryPhoneCode = action.title
            selectedImageView.image = action.image
            if let phoneCode = PhoneCode.getPhoneByID(id: action.discoverabilityTitle) {
                configureTextfield(with: phoneCode.textPlaceHolder, formatType: phoneCode.formatType)
            }
            self.selectMenuButton.setTitle(action.title, for: .normal)
            UserDefaults.standard.setValue(action.discoverabilityTitle, forKey: UserDefaultsKeys.phoneNumberCodeID)
            print(action.title)
        }
        
        selectMenuButton.menu = UIMenu(children: ConstantDatas.countryPhoneCodes.map({ phoneCode in
            UIAction(title: phoneCode.code, image: phoneCode.image, discoverabilityTitle: phoneCode.id, handler: handleButtonTap)
        }))
        
        selectMenuButton.showsMenuAsPrimaryAction = true
    }
    
    private func configureTextfield(with placeHolder: String, formatType: String) {
        inputField.attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: R.color.gray()!]
        )
        
        sharedInstance.formatter = DefaultTextInputFormatter(textPattern: formatType)
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
