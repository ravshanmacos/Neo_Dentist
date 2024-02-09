//
//  NDMainLightButton.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class NDMainLightButton: UIButton {
    
    //MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.layer.cornerRadius = 24
        self.backgroundColor = .white
        self.setTitleColor(R.color.blue_dark(), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func setTitle(text: String) {
        setTitle(text, for: .normal)
    }
}
