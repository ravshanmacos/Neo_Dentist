//
//  ErrorMessage.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 19/12/23.
//

import Foundation

struct ErrorMessage: Error {
    //MARK: Properties
    let id: UUID
    let title: String
    let message: String
    
    //MARK: Methods
    init(title: String, message: String) {
        self.id = UUID()
        self.title = title
        self.message = message
    }
}
extension ErrorMessage: Equatable {
    static func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
        return lhs.id == rhs.id
    }
}
