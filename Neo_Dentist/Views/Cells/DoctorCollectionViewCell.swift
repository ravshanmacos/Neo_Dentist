//
//  RecomendedDoctorCollectionViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit
import SnapKit

class DoctorCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "RecomendedDoctorCollectionViewCell"
    
    let doctorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.heart_icon_selected(), for: .selected)
        button.setImage(R.image.heart_icon_unselected(), for: .normal)
        return button
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
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DoctorCollectionViewCell {
    func setupUI(){
        addSubviews(doctorImageView, likeButton, vStack, vStack2)
        vStack.addArrangedSubviews(doctorNameLabel, doctorEducationLabel, doctorExpericenceLabel)
        vStack2.addArrangedSubviews(doctorWorkingDaysLabel, doctorRatingLabel)
    }
    func setupConstraints(){
        doctorImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(5)
            make.width.equalTo(102)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-5)
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
    func configureUI(){
        layer.borderWidth = 0.2
        layer.borderColor = R.color.gray_dark()?.cgColor
        layer.opacity = 0.4
        layer.cornerRadius = 12
    }
}
