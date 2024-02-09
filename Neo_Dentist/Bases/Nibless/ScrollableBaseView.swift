//
//  ScrollableBaseView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import UIKit

class ScrollableBaseView: BaseView {
    
    //MARK: Properties
    private let scrollView: UIScrollView = {
       let view = UIScrollView()
        view.backgroundColor = .clear
        view.isScrollEnabled = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    let scrollViewContent: UIView = {
       let view = UIView()
        view.layer.cornerRadius = 10
        return view
    }()
    
    let headerView = UIView()
    
    //MARK: Methods
    override func setupUI() {
        super.setupUI()
        addSubviews(headerView, scrollView)
        scrollView.addSubviews(scrollViewContent)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        headerView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalTo(headerView.snp.leading)
            make.trailing.equalTo(headerView.snp.trailing)
        }
        scrollViewContent.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(scrollView.snp.width)
        }
    }
}
