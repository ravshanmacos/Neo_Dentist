//
//  AppointmentHistoriesRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/01/24.
//

import UIKit
import Combine

enum AppointmentCardStyle {
    case withoutCancelButton
    case withCancelButton
}

class AppointmentHistoriesRootView: BaseView {
    //MARK: Properties
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.text = "История записей 📒"
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let segmentedControll = CustomSegmetedControl(buttonTitles: ["Предстоящие", "Завершенные", "Отмененные"], tintColor: R.color.blue_dark()!, fontSelected: .boldSystemFont(ofSize: 14),fontUnselected: .systemFont(ofSize: 14, weight: .semibold))
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        AppointmentCardTableViewCell.register(to: view)
        return view
    }()
    
    private let viewModel: AppointmentHistoriesViewModel
    private var subscriptions = Set<AnyCancellable>()
    private var cardStyle: AppointmentCardStyle = .withCancelButton
    
    //MARK: Methods
    init(frame: CGRect = .zero, viewModel: AppointmentHistoriesViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(titleLabel, segmentedControll, tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
        }
        
        segmentedControll.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControll.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        segmentedControll.delegate = self
        tableView.dataSource = self
    }
}

extension AppointmentHistoriesRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = AppointmentCardTableViewCell.dequeue(on: tableView, at: indexPath) else { return UITableViewCell() }
        cell.selectionStyle = .none
        let item = viewModel.appointments[indexPath.row]
        cell.doctorFieldView.rightSideLabel.text = item.doctor.fullName
        cell.serviceFieldView.rightSideLabel.text = item.service.name
        cell.dateFieldView.rightSideLabel.text = CalendarConfigure.shared.decodeAppointmentTimeSlot(dateString: item.appointmentTime, style: .original)
        cell.addressFieldView.rightSideLabel.text = item.address
        switch cardStyle {
        case .withCancelButton:
            cell.makeCellWithCancelButton()
            cell.cancelButton.tag = item.id
            cell.cancelButton.addTarget(viewModel, action: #selector(viewModel.cancelButtonTapped), for: .touchUpInside)
        case .withoutCancelButton:
            cell.makeCellWithoutCancelButton()
        }
        return cell
    }
}

//MARK: Bindings
extension AppointmentHistoriesRootView {
    func bindViewModelToView() {
        viewModel
            .$updateTableView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] update in
                guard let self, update else { return }
                tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension AppointmentHistoriesRootView: CustomSegmetedControlDelegate {
    func buttonPressed(buttonTitlesIndex: Int, title: String?) {
        switch buttonTitlesIndex {
        case 0:
            viewModel.filterAppointments(status: .pending)
            cardStyle = .withCancelButton
        case 1:
            viewModel.filterAppointments(status: .completed)
            cardStyle = .withoutCancelButton
        case 2:
            viewModel.filterAppointments(status: .canceled)
            cardStyle = .withoutCancelButton
        default:
            print("wrong one")
        }
        tableView.reloadData()
    }
}



