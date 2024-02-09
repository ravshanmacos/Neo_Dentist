//
//  LaunchRootView.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 03/02/24.
//

import Foundation

class LaunchRootView: BaseView {
    
    private let viewModel: LaunchViewModel
    
    init(frame: CGRect = .zero, viewModel: LaunchViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        loadUserSession()
    }
    
    func loadUserSession() {
        viewModel.loadUserSession()
    }
    
}
