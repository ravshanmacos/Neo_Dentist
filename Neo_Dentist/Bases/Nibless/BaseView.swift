//
//  BaseView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 18/12/23.
//

import UIKit

class BaseView: UIView {
    
    let titleTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let contentView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        configureUI()
    }
    
    @available(*, unavailable, message: "Loading this view from a nib is unsupported")
    
    required init?(coder: NSCoder) {
        fatalError("Loading this view from a nib is unsupported in favor of initializer dependency injection.")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        endEditing(true)
    }
    
    func setupUI(){
        addSubview(contentView)
    }
    func setupConstraints(){
        contentView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.left.equalTo(safeAreaLayoutGuide.snp.left).offset(16)
            make.right.equalTo(safeAreaLayoutGuide.snp.right).offset(-16)
        }
    }
    func configureUI(){
        backgroundColor = .white
    }
}
