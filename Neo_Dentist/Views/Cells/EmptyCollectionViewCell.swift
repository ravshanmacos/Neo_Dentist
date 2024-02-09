//
//  EmptyCollectionViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit

class EmptyCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "EmptyCollectionViewCell"
    
    let cellImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let cellTitleLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let cellDescriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    let actionButton: NDMainButton = {
       let button = NDMainButton()
        button.isEnabled = true
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
    
    func setupUI() {
        contentView.addSubviews(cellImageView, cellTitleLabel, cellDescriptionLabel, actionButton)
        cellImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalTo(102)
        }
        
        cellTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        cellDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(cellTitleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(cellDescriptionLabel.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    func configureUI(){}
}
