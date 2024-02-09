//
//  Optional+ext.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 04/02/24.
//

import Foundation

extension Optional {
    var isEmpty: Bool {
        return self == nil
    }
    
    var exists: Bool {
        self != nil
    }
}
