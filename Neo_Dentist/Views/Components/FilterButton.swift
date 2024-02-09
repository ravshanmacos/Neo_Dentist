//
//  FilterButton.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 11/01/24.
//

import Foundation
import UIKit

class FilterButton: UIView {
    
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        return label
    }()
    
    let removeButton: UIButton = {
        let button = UIButton()
        button.setImage(R.image.remove_filter_icon(), for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubviews(titleLabel, removeButton)
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }
        
        removeButton.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
    }
    
    private func configureUI() {
        layer.cornerRadius = 20
        layer.borderWidth = 0.3
        layer.borderColor = R.color.gray_dark()?.cgColor
        backgroundColor = R.color.gray_light()?.withAlphaComponent(0.4)
    }
    
}
