//
//  RemainingTimeLimitView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 20/12/23.
//

import UIKit

class RemainingTimeLimitView: BaseView {
    let titleLabel: NDLabel = {
        let label = NDLabel()
        label.mediumTitleBold()
        return label
    }()
    
    let remainingTimeLabel: NDLabel = {
        let label = NDLabel()
        label.mediumTitleBold()
        label.textColor = R.color.green_light()
        label.setTitle(text: "0:59")
        return label
    }()
    
    private let hStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 5
        return stack
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubview(hStack)
        hStack.addArrangedSubviews(titleLabel, remainingTimeLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        hStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        remainingTimeLabel.snp.makeConstraints { make in
            make.width.equalTo(screenWidth()*1/6)
        }
    }
    
    func enableSendConfirmationButton() {
        isUserInteractionEnabled = true
        remainingTimeLabel.isHidden = true
        titleLabel.textColor = R.color.blue_dark()
        titleLabel.setTitle(text: "Отправить код повторно")
    }
    
    func disableSendConfirmationButton() {
        isUserInteractionEnabled = false
        remainingTimeLabel.isHidden = false
        titleLabel.textColor = R.color.blue_disabled1()
        titleLabel.setTitle(text: "Отправить код повторно через:")
    }
}
