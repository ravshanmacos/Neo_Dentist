//
//  NDInfoComponentView2.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class NDInfoComponentView2: BaseView {
    let leftSideLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let rightSideLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubviews(leftSideLabel, rightSideLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        leftSideLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        
        rightSideLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
