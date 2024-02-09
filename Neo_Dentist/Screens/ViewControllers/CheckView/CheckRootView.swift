//
//  CheckRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class CheckRootView: BaseView {
    
    private let successMessageView = SuccessMessageView()
    let checkView = CheckView()
    let goBackMainButton: NDMainLightButton = {
       let button = NDMainLightButton()
        button.setTitle(text: "Вернуться на главную")
        return button
    }()
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(successMessageView, checkView, goBackMainButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        successMessageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        checkView.snp.makeConstraints { make in
            make.top.equalTo(successMessageView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        goBackMainButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
    }
}
