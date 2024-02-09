//
//  AppointmentDetailsTableviewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class AppointmentDetailsTableviewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.blue_dark()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let arrowImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = R.image.to_right_arrow()
        return view
    }()
    
    private let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    private let divider: UIView = {
       let view = UIView()
        view.backgroundColor = R.color.gray_light()
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubviews(titleLabel, hStack, divider)
        hStack.addArrangedSubviews(descriptionLabel, arrowImageView)
    }
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25)
            make.leading.equalToSuperview()
        }
        
        hStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview()
            
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
