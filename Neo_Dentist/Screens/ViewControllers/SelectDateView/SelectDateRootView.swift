//
//  SelectDateRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 30/12/23.
//

import UIKit
import Combine

class SelectDateRootView: BaseView {
    
    private let selectDateLabel = makeLabel(with: "Выберите дату приема")
    private let selectTimeLabel = makeLabel(with: "Выберите время приема")
    private let calendarView = CalendarView()
    private let timesView = TimesView()
    let nextButton: NDMainButton = {
       let button = NDMainButton()
        button.setTitle(text: "Далее")
        return button
    }()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: SelectDateViewModel
    
    init(frame: CGRect = .zero, viewModel: SelectDateViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(selectDateLabel, calendarView, selectTimeLabel, timesView, nextButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        selectDateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        calendarView.snp.makeConstraints { make in
            make.top.equalTo(selectDateLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(310)
        }
        
        selectTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(calendarView.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        timesView.snp.makeConstraints { make in
            make.top.equalTo(selectTimeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        selectTimeLabel.isHidden = true
        timesView.isHidden = true
        nextButton.isHidden = true
        
        calendarView.delegate = self
        timesView.delegate = self
        nextButton.addTarget(viewModel, action: #selector(viewModel.nextButtonTapped), for: .touchUpInside)
    }
}

private extension SelectDateRootView {
    static func makeLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }
}

extension SelectDateRootView: CalendarViewDelegate, TimesViewDelegate {
    func timeDidSelected(with chosen: AvailableHoursResponse) {
        viewModel.timeIsSelected(chosen: chosen)
    }
    
    func dayIsSelected(with dayNumber: Int) {
        viewModel.dayIsSelected(dayNumber: dayNumber)
    }
}

private extension SelectDateRootView {
    func bindViewModelToView() {
        viewModel
            .$doctorDescription
            .receive(on: DispatchQueue.main)
            .sink {[weak self] doctorDescription in
                guard let self, let doctorDescription else { return }
                calendarView.workingDays = doctorDescription.workDays
            }.store(in: &subscriptions)
        
        viewModel
            .$doctorAvailableHours
            .receive(on: DispatchQueue.main)
            .sink { [weak self] hours in
                guard let self, let hours else { return }
                timesView.timesData = hours
            }.store(in: &subscriptions)
        
        viewModel
            .$activateHoursView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] activate in
                guard let self, activate else { return }
                selectTimeLabel.isHidden = false
                timesView.isHidden = false
            }.store(in: &subscriptions)
        
        viewModel
            .$activateNextButton
            .receive(on: DispatchQueue.main)
            .sink { [weak self] activate in
                guard let self, activate else { return }
                nextButton.isHidden = false
                nextButton.isEnabled = true
            }.store(in: &subscriptions)
    }
}
