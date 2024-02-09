//
//  FilterDoctorsRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class FilterDoctorsRootView: BaseView {
    
    //MARK: Properties
    
    private let specializationButton: FeaturedButton = {
       let button = FeaturedButton()
        button.titleLabel.text = "Специализация"
        return button
    }()
    private let experienceButton: FeaturedButton = {
       let button = FeaturedButton()
        button.titleLabel.text = "Стаж работы"
        return button
    }()
    private let divider1 = Divider(style: .defaultLine)
    private let divider2 = Divider(style: .defaultLine)
    
    private let stack1 = makeHStack()
    private let stack2 = makeHStack()
    
    private let viewModel: FilterDoctorsViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    init(frame: CGRect = .zero, viewModel: FilterDoctorsViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindUpdateStack1()
    }
    override func setupUI() {
        super.setupUI()
        contentView.addSubviews(specializationButton, stack1, divider1)
        contentView.addSubviews(experienceButton, stack2, divider2)
    }
    override func setupConstraints() {
        super.setupConstraints()
        specializationButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.leading.trailing.equalToSuperview()
        }
        stack1.snp.makeConstraints { make in
            make.top.equalTo(specializationButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
        }
        divider1.snp.makeConstraints { make in
            make.top.equalTo(stack1.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
        
        experienceButton.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview()
        }
        stack2.snp.makeConstraints { make in
            make.top.equalTo(experienceButton.snp.bottom)
            make.trailing.leading.equalToSuperview()
        }
        divider2.snp.makeConstraints { make in
            make.top.equalTo(stack2.snp.bottom).offset(16)
            make.trailing.leading.equalToSuperview()
        }
    }
    override func configureUI() {
        super.configureUI()
        let specializationTapGesture = UITapGestureRecognizer(target: viewModel, action: #selector(viewModel.specializationButtonTapped))
        let experienceTapGesture = UITapGestureRecognizer(target: viewModel, action: #selector(viewModel.experienceButtonTapped))
        
        
        specializationButton.addGestureRecognizer(specializationTapGesture)
        experienceButton.addGestureRecognizer(experienceTapGesture)
    }
}

extension FilterDoctorsRootView {
    func bindUpdateStack1() {
        viewModel
            .$updateOptions
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .sink {[weak self] update in
                guard let self, update else { return }
                stack1.removeAllArrangedSubviews()
                viewModel.specializationOptions.enumerated().forEach {[weak self] (index, optionModel) in
                     guard let self else { return }
                     let filterBtn = makeFilterButton(index: index, optionModel: optionModel)
                     stack1.addArrangedSubview(filterBtn)
                     filterBtn.snp.makeConstraints { make in
                         make.height.equalTo(40)
                     }
                 }
            }.store(in: &subscriptions)
    }
}

extension FilterDoctorsRootView {
    func makeFilterButton(index: Int, optionModel: SpecializationModel) -> FilterButton {
        let filterBtn = FilterButton()
        filterBtn.titleLabel.text = optionModel.name
        filterBtn.removeButton.tag = index
        filterBtn.removeButton.addTarget(viewModel, action: #selector(viewModel.removeButtonTapped(_:)), for: .touchUpInside)
        return filterBtn
    }
    
    static func makeHStack() -> UIStackView {
        let stack = UIStackView()
         stack.axis = .horizontal
        stack.spacing = 5
         stack.distribution = .fill
         return stack
    }
}
