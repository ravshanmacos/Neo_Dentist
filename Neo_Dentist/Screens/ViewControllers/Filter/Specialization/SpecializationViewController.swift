//
//  SpecializationViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class SpecializationViewController: BaseViewController {
    private let viewModel: SpecializationViewModel
    private let rootView: SpecializationRootView
    
    init(viewModel: SpecializationViewModel) {
        self.viewModel = viewModel
        self.rootView = SpecializationRootView(viewModel: viewModel)
        super.init()
    }
    
    override func loadView() {
        super.loadView()
        view = rootView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(text: "Специализация")
        setBackButton()
    }
}
