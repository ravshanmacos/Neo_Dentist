//
//  FilterDoctorsViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class FilterDoctorsViewController: BaseViewController {
    
    //MARK: Properties
    private let viewModel: FilterDoctorsViewModel
    private let rootView: FilterDoctorsRootView
    private let factory: FilterDoctorsFactory
    private var subscriptions = Set<AnyCancellable>()
    
    init(viewModel: FilterDoctorsViewModel, factory: FilterDoctorsFactory) {
        self.viewModel = viewModel
        self.factory = factory
        self.rootView = FilterDoctorsRootView(viewModel: viewModel)
        super.init()
        bindNavigations()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(text: "Фильтр")
        setBackButton()
    }
    
}

private extension FilterDoctorsViewController {
    func bindNavigations() {
        viewModel
            .$openSpecializationView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] open in
                guard let self, open else { return }
                navigationController?.pushViewController(factory.makeSpecializationViewController(), animated: true)
            }.store(in: &subscriptions)
        
        viewModel
            .$openExperienceView
            .receive(on: DispatchQueue.main)
            .sink { [weak self] open in
                guard let self, open else { return }
                navigationController?.pushViewController(factory.makeExperienceViewController(), animated: true)
            }.store(in: &subscriptions)
        
        viewModel
            .$updateOptions
            .receive(on: DispatchQueue.main)
            .sink {[weak self] update in
                guard let self, update else { return }
                navigationController?.popToViewController(self, animated: true)
            }.store(in: &subscriptions)
    }
}
