//
//  FeaturedButton.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit

class FeaturedButton: BaseView {
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = R.image.to_right_arrow()
        return view
    }()
    
    private let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubview(hStack)
        hStack.addArrangedSubviews(titleLabel, arrowImageView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        hStack.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
}
