//
//  DoctorsListWithSearchBarAndFilter.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/01/24.
//

import UIKit
import Combine

class DoctorsListRootView: BaseView {
    
    //MARK: Properties
    private let searchBarView = SearchBarView()
    private let filterButton: UIButton = {
       let button = UIButton()
        button.layer.cornerRadius = 24
        button.backgroundColor = R.color.blue_dark()
        button.setImage(R.image.filter_icon(), for: .normal)
        return button
    }()
    private let hStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        DoctorCollectionViewCell.register(to: view)
        EmptyCollectionViewCell.register(to: view)
        return view
    }()
    
    private let viewModel: DoctorsListViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: DoctorsListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    //MARK: Methods
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(hStack, collectionView)
        hStack.addArrangedSubviews(searchBarView, filterButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        hStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
        }
        filterButton.snp.makeConstraints { make in
            make.width.equalTo(48)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(hStack.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = viewModel.doctorsData.isEmpty ? CGSize(width: contentWidth(), height: screenHeight()/2) : CGSize(width: contentWidth(), height: 126)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBarView.searchTextfield.delegate = self
       
        filterButton.addTarget(viewModel, action: #selector(viewModel.filterButtonTapped), for: .touchUpInside)
    }
    
    private func configureEmptyCell(with cell: EmptyCollectionViewCell) {
        cell.cellImageView.image = R.image.tooth_icon_18()
        cell.cellTitleLabel.text = "По вашему запросу ничего не найдено"
        cell.cellDescriptionLabel.text = "Попробуйте изменить запрос \nили свяжитесь с нами для помощи"
        cell.actionButton.isHidden = true
    }
    
    private func configureActiveCell(with cell: DoctorCollectionViewCell, and indexPath: IndexPath) {
        let item = viewModel.doctorsData[indexPath.row]
        cell.doctorNameLabel.text = item.fullname
        cell.doctorEducationLabel.text = item.specialization.name
        cell.doctorExpericenceLabel.text = configureExperienceLabel(experience: item.workExperience)
        cell.doctorWorkingDaysLabel.text = configureWorkingDaysLabel(days: item.workDays, start: item.startWorkTime, end: item.endWorkTime)
        if let rating = item.rating {
            cell.doctorRatingLabel.text = "Рейтинг: ⭐️ \(rating)"
        }
        cell.likeButton.isSelected = item.isFavorite
        if let url = item.getImageURL() {
            cell.doctorImageView.kf.setImage(with: url, placeholder: R.image.doctor_photo())
        }
        
    }
}

extension DoctorsListRootView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.getDoctors()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel.searchDoctor(with: textField.text)
        return true
    }
}

extension DoctorsListRootView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.doctorsData.isEmpty ? 1 : viewModel.doctorsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard !viewModel.doctorsData.isEmpty else {
            if let cell = EmptyCollectionViewCell.dequeue(on: collectionView, at: indexPath) {
                configureEmptyCell(with: cell)
                return cell
            }
            return UICollectionViewCell()
        }
        if let cell = DoctorCollectionViewCell.dequeue(on: collectionView, at: indexPath) {
            configureActiveCell(with: cell, and: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.doctorsData[indexPath.row]
        viewModel.navigateSingleDoctorView(with: item.id)
    }
}

private extension DoctorsListRootView {
    func bindViewModelToView() {
        viewModel
            .$doctorsData
            .receive(on: DispatchQueue.main)
            .sink {[weak self] doctorsData in
                guard let self else { return }
                collectionView.reloadData()
            }.store(in: &subscriptions)
    }
}
