//
//  NDLabel.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import UIKit

class NDLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        self.numberOfLines = 0
        self.textColor = R.color.dark()
        self.textAlignment = .center
    }
    
    func setTitle(text: String) {
        self.text = text
    }
}

extension NDLabel {
    func enableErrorLabel() {
        self.textColor = R.color.red_error()
        self.font = .systemFont(ofSize: 12, weight: .semibold)
    }
}

//MARK: Sizes
extension NDLabel {
    func largeTitle() {
        self.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
    func largeTitle2Bold() {
        self.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    func largeTitle2Semibold() {
        self.font = .systemFont(ofSize: 18, weight: .semibold)
    }
    
    func mediumTitle() {
        self.font = .systemFont(ofSize: 16, weight: .semibold)
    }
    
    func mediumTitleBold() {
        self.font = .systemFont(ofSize: 16, weight: .bold)
    }
    
    func smallTitle() {
        self.font = .systemFont(ofSize: 14, weight: .medium)
    }
    
    func smallSemiboldTitle() {
        self.font = .systemFont(ofSize: 12, weight: .semibold)
    }
}

//MARK: Font Style change
extension NDLabel {
    func makeItalic(text: String) {
        let italic = [NSAttributedString.Key.font: UIFont.italicSystemFont(ofSize: 12)]
        let mutableAttributedString = NSMutableAttributedString(string: text, attributes: italic)
        attributedText = mutableAttributedString
    }
}
