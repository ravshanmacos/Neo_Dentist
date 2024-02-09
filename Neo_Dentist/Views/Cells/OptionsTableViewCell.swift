//
//  OptionsTableViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit

enum OptionTableViewCellStyle {
    case circular
    case roundedRect
}

protocol OptionsTableViewCellDelegate: AnyObject {
    func IsChecked(at tag: Int, value: Bool)
}

class OptionsTableViewCell: UITableViewCell {
    
    //MARK: Properties
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let optionButton: UIButton = {
       let button = UIButton()
        return button
    }()
    var optionStyle: OptionTableViewCellStyle = .roundedRect
    var buttonisActive = false
    weak var delegate: OptionsTableViewCellDelegate?
    
    private let buttonHeight: CGFloat = 18
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureButton() {
        switch optionStyle {
        case .circular:
            optionButton.setBackgroundImage(R.image.checkbox_circle_icon(), for: .selected)
            optionButton.layer.cornerRadius = buttonHeight / 2
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = R.color.blue_dark()?.cgColor
        case .roundedRect:
            optionButton.setBackgroundImage(R.image.checkbox_icon(), for: .selected)
            optionButton.layer.cornerRadius = buttonHeight / 5
            optionButton.layer.borderWidth = 1
            optionButton.layer.borderColor = R.color.blue_dark()?.cgColor
        }
        
    }
    
    
    private func setupUI() {
        contentView.addSubviews(optionButton, titleLabel)
        optionButton.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.height.equalTo(buttonHeight)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(optionButton.snp.trailing).offset(16)
        }
    }
    
    func configureUI () {
        optionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        optionButton.isSelected.toggle()
        delegate?.IsChecked(at: optionButton.tag, value: optionButton.isSelected)
    }
}
