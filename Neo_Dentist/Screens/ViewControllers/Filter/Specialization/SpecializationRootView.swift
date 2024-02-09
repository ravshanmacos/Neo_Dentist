//
//  SpecializationRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class SpecializationRootView: BaseView {
    //MARK: Properties
    let tableView: UITableView = {
       let table = UITableView()
        table.rowHeight = 52
        table.separatorStyle = .none
        OptionsTableViewCell.register(to: table)
        return table
    }()
    
    let saveChangesButton: NDMainButton = {
       let button = NDMainButton()
        button.setTitle(text: "Применить")
        return button
    }()
    
    private let viewModel: SpecializationViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: SpecializationViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindOptionsData()
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(tableView, saveChangesButton)
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.equalTo(saveChangesButton.snp.top)
        }
        
        saveChangesButton.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func configureUI() {
        super.configureUI()
        tableView.dataSource = self
        saveChangesButton.addTarget(viewModel, action: #selector(viewModel.saveButtonTapped), for: .touchUpInside)
    }
}

extension SpecializationRootView : OptionsTableViewCellDelegate {
    func IsChecked(at tag: Int, value: Bool) {
        viewModel.options[tag - 1].isActive = value
    }
}

extension SpecializationRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = OptionsTableViewCell.dequeue(on: tableView, at: indexPath) else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.delegate = self
        let item = viewModel.options[indexPath.row]
        cell.titleLabel.text = item.name
        cell.configureButton()
        cell.optionButton.tag = indexPath.row + 1
        return cell
    }
}

private extension SpecializationRootView {
    func bindOptionsData() {
        viewModel
            .$options
            .receive(on: DispatchQueue.main)
            .sink { [self] optionsData in
                if optionsData != SpecializationModel.mockSpecializationData() {
                    saveChangesButton.isHidden = false
                    saveChangesButton.isEnabled = true
                } else {
                    saveChangesButton.isEnabled = false
                    saveChangesButton.isHidden = true
                }
            }.store(in: &subscriptions)
    }
}


