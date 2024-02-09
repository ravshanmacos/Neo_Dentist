//
//  NavigationAction.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 06/02/24.
//

import Foundation

enum NavigationAction<ViewModelType>: Equatable where ViewModelType: Equatable {
    case present(view: ViewModelType)
    case presented(view: ViewModelType)
}
