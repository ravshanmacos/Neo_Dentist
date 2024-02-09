//
//  AddView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit

class AddView: BaseView {
    
    let addTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    let addDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 7, weight: .semibold)
        return label
    }()
    
    let addAuthor: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 8, weight: .semibold)
        return label
    }()
    
    let addBackground: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    let addIcon: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    override func setupUI() {
        super.setupUI()
        addSubviews(addBackground, addIcon)
        addSubviews(addTitle, addDescription, addAuthor)
        
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        addBackground.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addIcon.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(10)
            make.width.equalTo(200)
        }
        addDescription.snp.makeConstraints { make in
            make.top.equalTo(addTitle.snp.bottom).offset(5)
            make.leading.equalTo(addTitle.snp.leading)
        }
        addAuthor.snp.makeConstraints { make in
            make.leading.equalTo(addTitle.snp.leading)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        layer.cornerRadius = 12
        layer.masksToBounds = true
    }
}
