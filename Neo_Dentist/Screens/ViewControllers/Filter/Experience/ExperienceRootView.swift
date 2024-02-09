//
//  ExperienceRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit

class ExperienceRootView: BaseView {
    //MARK: Properties
    let tableView: UITableView = {
       let table = UITableView()
        table.rowHeight = 52
        table.separatorStyle = .none
        OptionsTableViewCell.register(to: table)
        return table
    }()
    
    private let viewModel: ExperienceViewModel
    
    init(frame: CGRect = .zero, viewModel: ExperienceViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    override func setupUI() {
        super.setupUI()
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(24)
            $0.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    override func configureUI() {
        super.configureUI()
        tableView.dataSource = self
    }
}

extension ExperienceRootView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = OptionsTableViewCell.dequeue(on: tableView, at: indexPath) else { return UITableViewCell() }
        let item = viewModel.options[indexPath.row]
        cell.titleLabel.text = item.name
        cell.optionStyle = .circular
        cell.configureButton()
        
        return cell
    }
}
