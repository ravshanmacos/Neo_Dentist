//
//  AppointmentDetailsRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 02/01/24.
//

import UIKit
import Combine

class AppointmentDetailsRootView: BaseView {
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.separatorStyle = .none
        AppointmentDetailsTableviewCell.register(to: view)
        return view
    }()
    
    let nextButton: NDMainButton = {
       let button = NDMainButton()
        button.isEnabled = true
        button.setTitle(text: "Далее")
        return button
    }()
    private var subscriptions = Set<AnyCancellable>()
    private let viewModel: AppointmentDetailsViewModel
    
    init(frame: CGRect = .zero, viewModel: AppointmentDetailsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindAppointmentDataUpdate()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(tableView, nextButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(nextButton.snp.top)
        }
        nextButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-12)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        tableView.delegate = self
        tableView.dataSource = self
        nextButton.addTarget(viewModel, action: #selector(viewModel.nextButtonTapped), for: .touchUpInside)
    }
}

extension AppointmentDetailsRootView {
    func bindAppointmentDataUpdate() {
        viewModel
            .$updateTableView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] update in
                guard let self, update else { return }
                self.tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension AppointmentDetailsRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.appointmentData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = AppointmentDetailsTableviewCell.dequeue(on: tableView, at: indexPath) else { return UITableViewCell() }
        cell.selectionStyle = .none
        let item = viewModel.appointmentData[indexPath.row]
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        return cell
    }
}

extension AppointmentDetailsRootView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(at: indexPath)
    }
}
