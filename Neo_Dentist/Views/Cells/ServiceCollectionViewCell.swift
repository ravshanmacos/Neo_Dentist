//
//  ServiceCollectionViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import UIKit

class ServiceCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "ServiceCollectionViewCell"
    
    let cellImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let cellDesctiption: NDLabel = {
        let label = NDLabel()
        label.textAlignment = .center
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        contentView.addSubviews(cellImageView, cellDesctiption)
    }
    
    func setupConstraints() {
        cellImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(50)
        }
        
        cellDesctiption.snp.makeConstraints { make in
            make.top.equalTo(cellImageView.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        
    }
    
    func configureUI() {
        layer.borderWidth = 0.2
        layer.borderColor = R.color.gray_dark()?.cgColor
        layer.cornerRadius = 12
    }
}
