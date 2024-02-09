//
//  ViewModelProtocol.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 11/01/24.
//

import Foundation
import Combine

class ViewModelProtocol {
    
    //MARK: Properties
    var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    let errorMessageSubject = PassthroughSubject<ErrorMessage, Never>()
    @Published private(set) var signInActivityIndicatorAnimating = false
    
}
