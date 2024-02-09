//
//  CalendarCollectionViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 31/12/23.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    let dayLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = R.color.dark()
        return label
    }()
    
    static let reuseIdentifier = "CalendarCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(dayLabel)
        dayLabel.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func setDayLabelText(with text: Int) {
        dayLabel.text = String(text)
    }
    
    func setSelectedDay() {
        backgroundColor = R.color.blue_dark()
        let width = (contentWidth() - 30) / 7
        layer.cornerRadius = width/2
        dayLabel.textColor = .white
    }
    
    func clearDay() {
        backgroundColor = .white
        let width = (contentWidth() - 30) / 7
        layer.cornerRadius = 0
        dayLabel.textColor = R.color.dark()
    }
}

