//
//  RoundedCardView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 30/12/23.
//

import UIKit


class RoundedCardView: BaseView {
    
    //MARK: Properties
    let titleLabel = makeRoundedCardLabel(R.color.gray_dark())
    let descriptionLabel = makeRoundedCardLabel(R.color.blue_dark())
    let vStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.layer.cornerRadius = 12
        stack.backgroundColor = .white.withAlphaComponent(0.7)
        stack.layoutMargins = .init(top: 11, left: 0, bottom: 11, right: 0)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    //MARK: Methods
    init(frame: CGRect = .zero, title: String, description: String = "") {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        super.init(frame: frame)
    }
    
    override func setupUI() {
        super.setupUI()
        addSubview(vStack)
        vStack.addArrangedSubviews(titleLabel, descriptionLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        layer.cornerRadius = 12
        backgroundColor = .white.withAlphaComponent(0.7)
    }
}

private extension RoundedCardView {
    static func makeRoundedCardLabel(_ color: UIColor?) -> UILabel {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .semibold)
        label.textColor = color
        return label
    }
}
