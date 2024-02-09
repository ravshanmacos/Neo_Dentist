//
//  SuccessMessage.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import UIKit

struct SuccessMessage {
    //MARK: Properties
    let id: UUID
    let title: String
    let icon: UIImage?
    
    //MARK: Methods
    init(title: String, icon: UIImage? = R.image.tooth_icon_16()) {
        self.id = UUID()
        self.title = title
        self.icon = icon
    }
}
extension SuccessMessage: Equatable {
    static func ==(lhs: SuccessMessage, rhs: SuccessMessage) -> Bool {
        return lhs.id == rhs.id
    }
}
