//
//  LikedDoctorsRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class LikedDoctorsListRootView: BaseView {
    
    //MARK: Properties
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 8
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        DoctorCollectionViewCell.register(to: view)
        EmptyCollectionViewCell.register(to: view)
        return view
    }()
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: LikedDoctorsListViewModel
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: LikedDoctorsListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = viewModel.likedDoctorsData.isEmpty ? CGSize(width: contentWidth(), height: screenHeight()/2) : CGSize(width: contentWidth(), height: 126)
        }
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureEmptyCell(with cell: EmptyCollectionViewCell) {
        cell.cellImageView.image = R.image.tooth_icon_18()
        cell.cellTitleLabel.text = "Здесь пока что пусто"
        cell.cellDescriptionLabel.text = "Добавьте своих любимых докторов"
        cell.actionButton.setTitle(text: "К списку докторов")
    }
    
    private func configureActiveCell(with cell: DoctorCollectionViewCell, indexPath: IndexPath) {
        let item = viewModel.likedDoctorsData[indexPath.row]
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

extension LikedDoctorsListRootView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.likedDoctorsData.isEmpty ? 1 : viewModel.likedDoctorsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard !viewModel.likedDoctorsData.isEmpty else {
            if let cell = EmptyCollectionViewCell.dequeue(on: collectionView, at: indexPath) {
                configureEmptyCell(with: cell)
                return cell
            }
            return UICollectionViewCell()
        }
        if let cell = DoctorCollectionViewCell.dequeue(on: collectionView, at: indexPath) {
            configureActiveCell(with: cell, indexPath: indexPath)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = viewModel.likedDoctorsData[indexPath.row]
        viewModel.doctorCardDidSelected(with: item.id)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension LikedDoctorsListRootView {
    func bindViewModelToView() {
        viewModel
            .$likedDoctorsData
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self else { return }
                collectionView.reloadData()
            }.store(in: &subscriptions)
    }
}
