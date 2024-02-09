//
//  ClinicServicesRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 27/12/23.
//

import UIKit
import Combine

class ClinicServicesListRootView: BaseView {
    
    let clinicServicesView = ClinicServicesView()
    
    private let viewModel: ClinicServicesListViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: ClinicServicesListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(clinicServicesView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        clinicServicesView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        clinicServicesView.delegate = self
    }
}

extension ClinicServicesListRootView: ClinicServicesViewDelegate {
    func didSelected(for serviceID: Int) {
        viewModel.navigateToSingleServiceView(with: serviceID)
    }
}

private extension ClinicServicesListRootView {
    func bindViewModelToView() {
        viewModel
            .$clinicServices
            .receive(on: DispatchQueue.main)
            .sink {[weak self] clinicServices in
                guard let self else { return }
                clinicServicesView.data = clinicServices
                clinicServicesView.collectionView.reloadData()
            }.store(in: &subscriptions)
    }
}
