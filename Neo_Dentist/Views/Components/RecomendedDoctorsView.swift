//
//  RecomendedDoctorsView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit

class RecomendedDoctorsView: BaseView {
    
    lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let width = contentWidth()
        layout.itemSize = CGSize(width: width, height: 126)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var data: [SingleDoctorResponse]
    
    init(frame: CGRect = .zero, data: [SingleDoctorResponse]) {
        self.data = data
        super.init(frame: frame)
    }
    
    override func setupUI() {
        super.setupUI()
        addSubview(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        collectionView.delegate = self
        collectionView.dataSource = self
        DoctorCollectionViewCell.register(to: collectionView)
    }
}

extension RecomendedDoctorsView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = DoctorCollectionViewCell.dequeue(on: collectionView, at: indexPath) else { return UICollectionViewCell() }
        let item = data[indexPath.row]
        cell.doctorNameLabel.text = item.fullname
        cell.doctorEducationLabel.text = item.specialization.name
        cell.doctorExpericenceLabel.text = configureExperienceLabel(experience: item.workExperience)
        cell.doctorWorkingDaysLabel.text = "Рабочие дни: " + configureWorkingDaysLabel(days: item.workDays, start: item.startWorkTime, end: item.endWorkTime)
        if let rating = item.rating {
            cell.doctorRatingLabel.text = "Рейтинг: ⭐️\(rating)"
        }
        if let url = item.getImageURL() {
            cell.doctorImageView.kf.setImage(with: url, placeholder: R.image.doctor_photo())
        }
        
        cell.likeButton.isHidden = true
        return cell
    }
}

extension RecomendedDoctorsView: UICollectionViewDelegate, UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout  = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludeSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludeSpacing
        let roundedIndex = round(index)
        offset = CGPoint(x: roundedIndex * cellWidthIncludeSpacing - scrollView.contentInset.left, y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}


