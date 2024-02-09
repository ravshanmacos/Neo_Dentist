//
//  ExperienceViewController.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 05/01/24.
//

import UIKit
import Combine

class ExperienceViewController: BaseViewController {
    private let viewModel: ExperienceViewModel
    private let rootView: ExperienceRootView
    
    init(viewModel: ExperienceViewModel) {
        self.viewModel = viewModel
        self.rootView = ExperienceRootView(viewModel: viewModel)
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
        setTitle(text: "Стаж работы")
        setBackButton()
    }
}
