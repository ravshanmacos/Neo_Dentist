//
//  NDInfoComponentView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import UIKit

class NDInfoComponentView: BaseView {
    let infoLabel: NDLabel = {
        let label = NDLabel()
        label.largeTitle2Bold()
        return label
    }()
    
    let infoButton: UIButton = {
       let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.setTitleColor(R.color.blue_dark(), for: .normal)
        return button
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubviews(infoLabel, infoButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        infoLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
        }
    }
}
