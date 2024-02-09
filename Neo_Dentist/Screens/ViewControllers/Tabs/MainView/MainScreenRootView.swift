//
//  MainRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 25/12/23.
//

import UIKit
import Combine

class MainScreenRootView: ScrollableBaseView {
    //MARK: Properties
    private let titleLabel: NDLabel = {
       let label = NDLabel()
        label.largeTitle()
        label.largeTitle()
        label.textAlignment = .left
        return label
    }()
    
    private let likedDoctorsButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 16
        button.setImage(R.image.heart_featured_icon(), for: .normal)
        button.backgroundColor = R.color.blue_dark()
        return button
    }()
    
    private let infoComponentView: NDInfoComponentView = {
       let view = NDInfoComponentView()
        view.infoLabel.setTitle(text: "Услуги клиники")
        view.infoButton.setTitle("Еще", for: .normal)
        return view
    }()
    
    private let clinicServicesView = ClinicServicesView()
    
    private let addView: AddView = {
       let view = AddView()
        view.addBackground.image = R.image.add_bck()
        view.addIcon.image = R.image.add_icon()
        view.addTitle.text = "Новый учебный год \nсо здоровыми зубками!"
        view.addDescription.text = "В честь 1-го сентября скидка 20% \nна посещение детского стоматолога"
        view.addAuthor.text = "Дентал Юникс"
        return view
    }()
    
    private let infoComponentView2: NDInfoComponentView = {
       let view = NDInfoComponentView()
        view.infoLabel.setTitle(text: "Рекомендуемые докторы")
        view.infoButton.setTitle("Еще", for: .normal)
        return view
    }()
    
    private let recomendedDoctorCard = DoctorCardView()
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: MainScreenViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        headerView.addSubviews(titleLabel, likedDoctorsButton)
        scrollViewContent.addSubviews(infoComponentView, clinicServicesView, addView, infoComponentView2, recomendedDoctorCard)
        
        let tapGesture = UITapGestureRecognizer(target: viewModel, action: #selector(viewModel.recomendedDoctorTapped))
        recomendedDoctorCard.addGestureRecognizer(tapGesture)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
        }
        likedDoctorsButton.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.height.width.equalTo(32)
        }
        
        infoComponentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        clinicServicesView.snp.makeConstraints { make in
            let height = ((screenWidth() - 48)/3) * 2 + 16
            make.top.equalTo(infoComponentView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(height)
        }
        
        addView.snp.makeConstraints { make in
            make.top.equalTo(clinicServicesView.snp.bottom).offset(30)
            make.trailing.leading.equalToSuperview()
        }
        
        infoComponentView2.snp.makeConstraints { make in
            make.top.equalTo(addView.snp.bottom).offset(30)
            make.leading.trailing.equalToSuperview()
        }
        
        recomendedDoctorCard.snp.makeConstraints { make in
            make.top.equalTo(infoComponentView2.snp.bottom).offset(8)
            make.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
            
            //make.height.equalTo(150)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        clinicServicesView.delegate = self
        
        infoComponentView.infoButton.addTarget(viewModel, action: #selector(viewModel.openAllServicesTapped), for: .touchUpInside)
        infoComponentView2.infoButton.addTarget(viewModel, action: #selector(viewModel.openDoctorsListTapped), for: .touchUpInside)
        likedDoctorsButton.addTarget(viewModel, action: #selector(viewModel.openLikedDoctorsTapped), for: .touchUpInside)
    }
    
    func setUserName(text: String?) {
        titleLabel.text = "Привет, \n\(text ?? "")! 👋"
    }
}

extension MainScreenRootView: ClinicServicesViewDelegate {
    func didSelected(for serviceID: Int) {
        viewModel.serviceTapped(with: serviceID)
    }
}

private extension MainScreenRootView {
    func bindViewModelToView() {
        viewModel
            .$clinicServices
            .receive(on: DispatchQueue.main)
            .sink {[weak self] clinicServices in
                guard let self else { return }
                clinicServicesView.data = clinicServices
                clinicServicesView.collectionView.reloadData()
            }.store(in: &subscriptions)
        
        viewModel
            .$advertisement
            .receive(on: DispatchQueue.main)
            .sink {[weak self] advertisement in
                guard let self, let advertisement else { return }
                addView.addTitle.text = advertisement.title
                addView.addDescription.text = advertisement.text
                addView.addAuthor.text = advertisement.author
                addView.addIcon.image = R.image.add_icon()
                if let url = advertisement.getImageURL() {
                    addView.addBackground.kf.setImage(with: url)
                }
            }.store(in: &subscriptions)
        
        viewModel
            .$recomendedDoctors
            .receive(on: DispatchQueue.main)
            .sink {[weak self] item in
                guard let self, let item else { return }
                recomendedDoctorCard.doctorNameLabel.text = item.fullname
                recomendedDoctorCard.doctorEducationLabel.text = item.specialization.name
                recomendedDoctorCard.doctorExpericenceLabel.text = configureExperienceLabel(experience: item.workExperience)
                recomendedDoctorCard.doctorWorkingDaysLabel.text = "Рабочие дни: " + configureWorkingDaysLabel(days: item.workDays, start: item.startWorkTime, end: item.endWorkTime)
                if let rating = item.rating {
                    recomendedDoctorCard.doctorRatingLabel.text = "Рейтинг: ⭐️ \(rating)"
                }
                if let url = item.getImageURL() {
                    recomendedDoctorCard.doctorImageView.kf.setImage(with: url, placeholder: R.image.doctor_photo())
                }
            }.store(in: &subscriptions)
        
    }
}
