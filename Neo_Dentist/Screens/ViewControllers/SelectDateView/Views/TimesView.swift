//
//  TimesView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 30/12/23.
//

import UIKit

protocol TimesViewDelegate: AnyObject {
    func timeDidSelected(with chosen: AvailableHoursResponse)
}

class TimesView: BaseView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 0
        layout.itemSize = .init(width: itemWidth(), height: itemWidth()/3)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(TimesViewCollectionViewCell.self, forCellWithReuseIdentifier: TimesViewCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .clear
        return view
    }()
    
    var timesData: [AvailableHoursResponse] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private var selectedTime: AvailableHoursResponse?
    var delegate: TimesViewDelegate?
    
    override func setupUI() {
        super.setupUI()
        addSubviews(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    override func configureUI() {
        super.configureUI()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension TimesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        timesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TimesViewCollectionViewCell.reuseIdentifier, for: indexPath) as! TimesViewCollectionViewCell
        let item = timesData[indexPath.row]
        cell.layer.cornerRadius = itemWidth()/6
        cell.titleLabel.text = item.timeSlot
        if let selectedTime, item.timeSlot == selectedTime.timeSlot {
            cell.selectedState()
        } else {
            cell.notSelectedState()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = timesData[indexPath.row]
        selectedTime = item
        delegate?.timeDidSelected(with: item)
        collectionView.reloadData()
    }
}

extension TimesView: UICollectionViewDelegate {
    func itemWidth() -> CGFloat {
        return (contentWidth() - 16) / 3
    }
}
