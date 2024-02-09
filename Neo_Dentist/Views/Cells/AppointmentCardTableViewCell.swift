//
//  AppointmentCardCollectionViewCell.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import UIKit

class AppointmentCardTableViewCell: UITableViewCell {
    //MARK: Properties
    
    let doctorFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Доктор"
        return view
    }()
    let serviceFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Услуга"
        return view
    }()
    let dateFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Дата и время"
        return view
    }()
    let addressFieldView: NDInfoComponentView2 = {
        let view = NDInfoComponentView2()
        view.leftSideLabel.text = "Адрес"
        return view
    }()
    let cancelButton: UIButton = {
       let button = UIButton()
        button.setTitleColor(R.color.red_error(), for: .normal)
        button.setTitle("Отменить запись", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }()
    private let contentWrapper: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 12
        view.isLayoutMarginsRelativeArrangement = true
        view.layer.borderColor = R.color.yellow()?.cgColor
        view.layoutMargins = .init(top: 0, left: 0, bottom: 10, right: 0)
        return view
    }()
    private let vStack = CheckView.makeVStackView()
    private let calendarConfigure = CalendarConfigure.shared
    
    //MARK: Methods
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(contentWrapper)
        contentWrapper.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    func setupUIElementsInfo(appointmentResponse: AppointmentsResponse) {
        doctorFieldView.rightSideLabel.text = appointmentResponse.doctor.fullName
        serviceFieldView.rightSideLabel.text = appointmentResponse.service.name
        dateFieldView.rightSideLabel.text = calendarConfigure.decodeAppointmentTimeSlot(dateString: appointmentResponse.appointmentTime, style: .original)
        addressFieldView.rightSideLabel.text = appointmentResponse.address
    }
    
    func makeCellWithCancelButton(){
        contentWrapper.removeAllSubviews()
        vStack.removeAllArrangedSubviews()
        
        contentWrapper.addArrangedSubviews(vStack, cancelButton)
        vStack.addArrangedSubviews(doctorFieldView, serviceFieldView, dateFieldView, addressFieldView)
    }
    
    func makeCellWithoutCancelButton(){
        contentWrapper.removeAllSubviews()
        vStack.removeAllArrangedSubviews()
        
        contentWrapper.addArrangedSubviews(vStack)
        vStack.addArrangedSubviews(doctorFieldView, serviceFieldView, dateFieldView, addressFieldView)
    }
}

