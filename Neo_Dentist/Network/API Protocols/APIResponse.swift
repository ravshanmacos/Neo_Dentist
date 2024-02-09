//
//  APIResponse.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import SwiftyJSON

protocol APIResponse {
    var response: HTTPURLResponse? { get }
    var result: Data? { get }
    func body(for key: String?) -> Any?
}

extension APIResponse {
    func body(for key: String?) -> Any? {
        return result
    }
    
    func jsonBody() -> JSON? {
        guard let result else { return nil }
        return JSON(result)
    }
    
    var isHasError: Bool {
        guard let result else { return false }
        return JSON(result)["error"].exists()
    }
    
    var error: Error? {
        guard isHasError else { return nil }
        guard let result else { return nil }
        let json = JSON(result)
        let jsonError = json["error"]
        return NSError.error(desc: jsonError["message"].stringValue,
                                  code: jsonError["code"].intValue,
                                  userInfo: jsonError["data"].dictionaryObject ?? [:])
    }
}

extension NSError {
    static func error(desc: String = "unknown_error_header",
                      code: Int = -1, domain: String = "",
                      userInfo: [String: Any] = [:]) -> NSError {
        var userInfo = userInfo
        userInfo[NSLocalizedDescriptionKey] = desc
        return NSError(domain: domain, code: code, userInfo: userInfo)
    }
}
