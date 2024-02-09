//
//  RESTAPIResponse.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import SwiftyJSON

struct RESTAPIResponse: APIResponse {
    var response: HTTPURLResponse?
    
    var result: Data?
    
    func body(for key: String?) -> Any? {
        guard let result else { return nil }
        if let key { return JSON(result)[key].rawValue }
        return JSON(result).rawValue
    }
    
    func jsonBody() -> JSON? {
        guard let result else { return nil }
        return JSON(result)
    }
    
    var error: Error?
    var isHasError: Bool {
        return error != nil
    }
}


