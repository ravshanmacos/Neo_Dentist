//
//  DoctorCardView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/01/24.
//

import UIKit
import SnapKit

class DoctorCardView: BaseView {
    
    let doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let doctorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let doctorEducationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let doctorExpericenceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    let doctorWorkingDaysLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.blue_dark()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    let doctorRatingLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 10, weight: .medium)
        return label
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    private let vStack2: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    //MARK: Methods
    override func setupUI() {
        super.setupUI()
        addSubviews(doctorImageView, vStack, vStack2)
        vStack.addArrangedSubviews(doctorNameLabel, doctorEducationLabel, doctorExpericenceLabel)
        vStack2.addArrangedSubviews(doctorWorkingDaysLabel, doctorRatingLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        doctorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(102)
            make.height.equalTo(116)
        }
        
        vStack.snp.makeConstraints { make in
            make.leading.equalTo(doctorImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-5)
            make.top.equalToSuperview().offset(10)
        }
        
        vStack2.snp.makeConstraints { make in
            make.leading.equalTo(doctorImageView.snp.trailing).offset(8)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        layer.borderWidth = 0.2
        layer.borderColor = R.color.gray_dark()?.cgColor
        layer.cornerRadius = 12
    }
}


