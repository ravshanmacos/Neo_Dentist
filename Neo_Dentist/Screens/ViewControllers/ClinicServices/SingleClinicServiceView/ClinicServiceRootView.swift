//
//  InfoAboutServiceRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit
import Combine

class ClinicServiceRootView: BaseView {
    
    //MARK: Properties
    
    private let vStack1 = makeVStack()
    private let vStack2 = makeVStack()
    private let titleLabel = makeTitleLabel()
    private let descriptionLabel = makeDescriptionLabel()
    private let priceTitleLabel = makeTitleLabel(text: "Цена")
    private let priceLabel = makeFeaturedLabel(with: "2000-3000 сом")
    private let recomendedDoctorsLabel = makeTitleLabel(text: "Рекомендуемые докторы")
    private let recomendedDoctorCardView = DoctorCardView()
    
    let makeAppointmentButton: NDMainButton = {
        let button = NDMainButton()
        button.isEnabled = true
        return button
    }()
    
    private let viewModel: ClinicServiceViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: ClinicServiceViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(vStack1, vStack2, recomendedDoctorsLabel, recomendedDoctorCardView, makeAppointmentButton)
        vStack1.addArrangedSubviews(titleLabel, descriptionLabel)
        vStack2.addArrangedSubviews(priceTitleLabel, priceLabel)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview()
        }
        vStack2.snp.makeConstraints { make in
            make.top.equalTo(vStack1.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        recomendedDoctorsLabel.snp.makeConstraints { make in
            make.top.equalTo(vStack2.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        recomendedDoctorCardView.snp.makeConstraints { make in
           make.top.equalTo(recomendedDoctorsLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
        
        makeAppointmentButton.snp.makeConstraints { make in
            make.top.equalTo(recomendedDoctorCardView.snp.bottom).offset(24)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        makeAppointmentButton.addTarget(viewModel, action: #selector(viewModel.makeAppointmentButtonTapped), for: .touchUpInside)
    }
}

//MARK: Components
extension ClinicServiceRootView {
    static func makeTitleLabel(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }
    
    static func makeDescriptionLabel() -> UILabel {
        let label = UILabel()
         label.numberOfLines = 0
         label.textColor = R.color.gray()
         label.font = .systemFont(ofSize: 14, weight: .medium)
        return label
    }
    
    static func makeFeaturedLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.textColor = R.color.blue_dark()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }
    
    static func makeVStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }
}

extension ClinicServiceRootView {
    func bindViewModelToView() {
        viewModel
            .$serviceInfo
            .receive(on: DispatchQueue.main)
            .sink {[weak self] serviceInfo in
                guard let self, let serviceInfo else { return }
                titleLabel.text = serviceInfo.name
                descriptionLabel.text = serviceInfo.description
                priceLabel.text = "\(serviceInfo.minPrice)-\(serviceInfo.maxPrice)"
                recomendedDoctorCardView.doctorNameLabel.text = serviceInfo.recommendedDoctor.fullname
                recomendedDoctorCardView.doctorEducationLabel.text = serviceInfo.recommendedDoctor.specialization.name
                recomendedDoctorCardView.doctorExpericenceLabel.text = configureExperienceLabel(experience: serviceInfo.recommendedDoctor.workExperience)
                recomendedDoctorCardView.doctorWorkingDaysLabel.text = "Рабочие дни: " + configureWorkingDaysLabel(days: serviceInfo.recommendedDoctor.workDays, start: serviceInfo.recommendedDoctor.startWorkTime, end: serviceInfo.recommendedDoctor.endWorkTime)
                if let rating = serviceInfo.recommendedDoctor.rating {
                    recomendedDoctorCardView.doctorRatingLabel.text = "Рейтинг: ⭐️ \(rating)"
                }
                if let url = serviceInfo.recommendedDoctor.getImageURL() {
                    recomendedDoctorCardView.doctorImageView.kf.setImage(with: url, placeholder: R.image.doctor_photo())
                }
                
            }.store(in: &subscriptions)
    }
}
