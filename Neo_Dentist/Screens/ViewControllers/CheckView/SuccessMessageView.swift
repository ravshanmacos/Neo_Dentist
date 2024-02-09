//
//  SuccessMessageView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class SuccessMessageView: BaseView {
    let imageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = R.image.tooth_icon_17()
        return view
    }()
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Спасибо за запись! \nМы будем ждать вас!"
        label.numberOfLines = 0
        label.textColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubviews(imageView, titleLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(112)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        backgroundColor = .clear
    }
}

