//
//  SearchBarView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit

class SearchBarView: BaseView {
    private let searchIconView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.search_icon()
        view.contentMode = .scaleAspectFit
        return view
    }()

    let searchTextfield: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Я ищу..."
        return textfield
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubviews(searchIconView, searchTextfield)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        searchIconView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(16)
        }
        searchTextfield.snp.makeConstraints { make in
            make.leading.equalTo(searchIconView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        layer.borderColor = R.color.gray_dark()?.cgColor
        layer.borderWidth = 0.3
        layer.cornerRadius = 24
    }
}

/*
 let settingsButton: UIButton = {
     let button = UIButton()
     
     return button
 }()
 
 private let hStack: UIStackView = {
    let stack = UIStackView()
     stack.spacing = 10
     stack.axis = .horizontal
     stack.distribution = .fill
     return stack
 }()
 */
