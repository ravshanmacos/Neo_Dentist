//
//  UIStackView+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
    
    func removeAllArrangedSubviews() {
        arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }
    }
}
