//
//  AboutDoctorRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/01/24.
//

import UIKit
import Combine

class DoctorRootView: BaseView {
    
    let doctorImageView: UIImageView = {
       let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.image = R.image.doctor_photo_large()
        return view
    }()
    let experienceCard = RoundedCardView(title: "Стаж")
    let ratingCard = RoundedCardView(title: "Рейтинг")
    let bottomSheetView: BaseView = {
       let view = BaseView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        return view
    }()
    
    let doctorNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.blue_dark()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    let doctorEducationLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        stack.distribution = .fill
        return stack
    }()
    
    let makeAppointmentButton: NDMainButton = {
        let button = NDMainButton()
        button.isEnabled = true
        button.setTitle(text: "Далее")
        return button
    }()
    
    private let divider: UIView = {
       let view = UIView()
        view.backgroundColor = R.color.gray_light()
        return view
    }()
    
    private let doctorSpecilizationLabel: UILabel = {
       let label = UILabel()
        label.text = "Специализация"
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let doctorSpecilizationDescriptionLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.gray_dark()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private let workingHoursTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "График работы"
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let workingHoursLabel: UILabel = {
       let label = UILabel()
        label.textColor = R.color.blue_dark()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: DoctorViewModel
    
    init(frame: CGRect = .zero, viewModel: DoctorViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        addSubviews(doctorImageView, hStack, bottomSheetView)
        hStack.addArrangedSubviews(experienceCard, ratingCard)
        bottomSheetView.contentView.addSubviews(vStack, divider, doctorSpecilizationLabel, doctorSpecilizationDescriptionLabel, workingHoursTitleLabel, workingHoursLabel, makeAppointmentButton)
        vStack.addArrangedSubviews(doctorNameLabel, doctorEducationLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        doctorImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(screenHeight() * 2/5)
        }
        hStack.snp.makeConstraints { make in
            make.bottom.equalTo(doctorImageView.snp.bottom).offset(-10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        bottomSheetView.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(-5)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(vStack.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
        
        doctorSpecilizationLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        doctorSpecilizationDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(doctorSpecilizationLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        workingHoursTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(doctorSpecilizationDescriptionLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview()
        }
        
        workingHoursLabel.snp.makeConstraints { make in
            make.top.equalTo(workingHoursTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
        }
        
        makeAppointmentButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        makeAppointmentButton.addTarget(viewModel, action: #selector(viewModel.nextButtonTapped), for: .touchUpInside)
         """
          \u{2022}  Установка брекет-систем для выравнивания
            зубов.
        
          \u{2022}  Регулярные настройки и коррекции брекетов.

          \u{2022}  Удаление брекетов по окончании лечения.

          \u{2022}  Имплантация зубов или коррекция челюстей
             для решения более серьезных проблем
             прикуса.
        """
    }
}

extension DoctorRootView {
    func bindViewModelToView() {
        viewModel
            .$doctorDescription
            .receive(on: DispatchQueue.main)
            .sink {[weak self] doctorDescription in
                guard let self, let doctorDescription else { return }
                experienceCard.descriptionLabel.text = "\(doctorDescription.workExperience) лет"
                doctorEducationLabel.text = doctorDescription.specialization.name
                doctorNameLabel.text = doctorDescription.fullname
                if let rating = doctorDescription.rating {
                    ratingCard.descriptionLabel.text = "\(rating)"
                }
                
                workingHoursLabel.text = configureWorkingDaysLabel(days: doctorDescription.workDays,
                                                                   start: doctorDescription.startWorkTime,
                                                                   end: doctorDescription.endWorkTime)
                doctorSpecilizationDescriptionLabel.text = doctorDescription.description
                if let url = doctorDescription.getImageURL() {
                    doctorImageView.kf.setImage(with: url, placeholder: R.image.doctor_photo_large())
                }
            }.store(in: &subscriptions)
    }
}
