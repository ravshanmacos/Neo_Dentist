//
//  UserProfileRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/01/24.
//

import UIKit
import Combine

class UserProfileRootView: BaseView {
    
    //MARK: Properties
    private let fullnameLabel = makeLargeLabel(text: "")
    private let usernameLabel = makeSmallLabel(text: "")
    private let phoneNumberLabel = makeSmallLabel(text: "")
    private let editProfileButton = makeFeaturedButton(title: "Редактировать профиль", color: R.color.blue_dark())
    private let logoutButton = makeFeaturedButton(title: "Выйти", color: R.color.red_error())
    private let upcomingAppoinmentMarkLabel = makeLargeLabel(text: "Мои предстоящие приемы")
    private let divider = Divider(style: .defaultLine)
    private let vStack: UIStackView = {
       let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fill
        return stack
    }()
    private let tableView: UITableView = {
        let view = UITableView()
        view.showsVerticalScrollIndicator = false
        AppointmentCardTableViewCell.register(to: view)
        return view
    }()
    private var subscriptions = Set<AnyCancellable>()
    private let calendarConfigure = CalendarConfigure.shared
    private let viewModel: UserProfileViewModel
    
    init(frame: CGRect = .zero, viewModel: UserProfileViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModelToView()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(vStack, logoutButton, divider, upcomingAppoinmentMarkLabel, tableView)
        vStack.addArrangedSubviews(fullnameLabel, usernameLabel, phoneNumberLabel, editProfileButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview()
        }
        
        editProfileButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(vStack.snp.bottom)
            make.leading.equalToSuperview()
            make.height.equalTo(48)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        upcomingAppoinmentMarkLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(upcomingAppoinmentMarkLabel.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        tableView.dataSource = self
        editProfileButton.addTarget(viewModel, action: #selector(viewModel.editProfileButtonTapped), for: .touchUpInside)
        logoutButton.addTarget(viewModel, action: #selector(viewModel.logoutButtonTapped), for: .touchUpInside)
    }
    
}

extension UserProfileRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.appointments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = AppointmentCardTableViewCell.dequeue(on: tableView, at: indexPath) else { return UITableViewCell() }
        cell.selectionStyle = .none
        let item = viewModel.appointments[indexPath.row]
        cell.setupUIElementsInfo(appointmentResponse: item)
        cell.makeCellWithCancelButton()
        cell.cancelButton.tag = item.id
        cell.cancelButton.titleLabel?.tag = indexPath.row
        cell.cancelButton.addTarget(viewModel, action: #selector(viewModel.cancelButtonTapped), for: .touchUpInside)
        return cell
    }
}

extension UserProfileRootView {
    func bindViewModelToView() {
        viewModel
            .$updateView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] update in
                guard let self, update else { return }
                self.fullnameLabel.text = viewModel.firstName + " " + viewModel.lastName
                self.usernameLabel.text = viewModel.userName
                self.phoneNumberLabel.text = viewModel.phoneNumber
            }.store(in: &subscriptions)
        
        viewModel
            .$updateTableView
            .receive(on: DispatchQueue.main)
            .sink {[weak self] update in
                guard let self, update else { return }
                self.tableView.reloadData()
            }.store(in: &subscriptions)
    }
}

extension UserProfileRootView {
    static func makeFeaturedButton(title: String = "", color: UIColor?) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(color, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        return button
    }
    
    static func makeLargeLabel(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = R.color.dark()
        label.font = .systemFont(ofSize: 18, weight: .bold)
        return label
    }
    
    static func makeSmallLabel(text: String = "") -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = R.color.gray_dark()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }
}
