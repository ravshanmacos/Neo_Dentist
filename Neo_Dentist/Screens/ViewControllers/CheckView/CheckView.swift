//
//  CheckView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit

class CheckView: BaseView {
    let firstnameFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Имя"
        view.rightSideLabel.text = "Бексултан"
        return view
    }()
    
    let lastnameFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Фамилия"
        view.rightSideLabel.text = "Маратов"
        return view
    }()
    
    let phoneFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Номер телефона"
        view.rightSideLabel.text = "+996555749509"
        return view
    }()
    
    let doctorFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Доктор"
        view.rightSideLabel.text = "Смирнова Анна Ивановна"
        return view
    }()
    
    let serviceFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Услуга"
        view.rightSideLabel.text = "Пломбирование зубов"
        return view
    }()
    
    let dateFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Дата и время"
        view.rightSideLabel.text = "20.09.2023, 13:00"
        return view
    }()
    
    let addressFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Адрес"
        view.rightSideLabel.text = "Киевская 108/1а"
        return view
    }()
    
    private let vStack = makeVStackView()
    private let vStack2 = makeVStackView()
    private let divider = Divider(style: .dashed)
    
    override func setupUI() {
        super.setupUI()
        addSubviews(vStack, divider, vStack2)
        vStack.addArrangedSubviews(firstnameFieldView, lastnameFieldView, phoneFieldView)
        vStack2.addArrangedSubviews(doctorFieldView, serviceFieldView, dateFieldView, addressFieldView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(vStack.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        vStack2.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        backgroundColor = .white
    }
}

extension CheckView {
    static func makeVStackView() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fill
        stack.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }
}

