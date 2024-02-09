//
//  ClinicServicesView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit
import Kingfisher

protocol ClinicServicesViewDelegate {
    func didSelected(for serviceID: Int)
}

class ClinicServicesView: BaseView {
    
    //MARK: Properties
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        let width = screenWidth() - 48
        layout.itemSize = CGSize(width: width/3, height: width/3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var data: [SingleServiceResponse]
    var delegate: ClinicServicesViewDelegate?
    
    //MARK: Methods
    init(frame: CGRect = .zero, data: [SingleServiceResponse] = []) {
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
        collectionView.register(ServiceCollectionViewCell.self, forCellWithReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier)
    }
}

extension ClinicServicesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCollectionViewCell.reuseIdentifier, for: indexPath) as! ServiceCollectionViewCell
        let item = data[indexPath.row]
        cell.cellDesctiption.text = item.name
        if let url = item.getImageURL() {
            cell.cellImageView.kf.setImage(with: url)
        }
        return cell
    }
}

extension ClinicServicesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = data[indexPath.row]
        delegate?.didSelected(for: item.id)
    }
}
