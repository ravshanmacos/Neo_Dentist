//
//  TimesViewCollectionViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class TimesViewCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "TimesViewCollectionViewCell"
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        layer.borderWidth = 1
        layer.borderColor = R.color.blue_dark()?.cgColor
        
        contentView.addSubviews(titleLabel)
        titleLabel.snp.makeConstraints{$0.center.equalToSuperview()}
    }
    
    func selectedState() {
        backgroundColor = R.color.blue_dark()
        titleLabel.textColor = .white
    }
    
    func notSelectedState() {
        backgroundColor = .white
        titleLabel.textColor = R.color.blue_dark()
    }
}
