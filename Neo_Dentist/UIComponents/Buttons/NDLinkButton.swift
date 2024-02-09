//
//  NDLinkButton.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import UIKit

class NDLinkButton: UIButton {
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
        self.setTitleColor(R.color.blue_dark(), for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func setTitle(text: String) {
        setTitle(text, for: .normal)
    }
}
