//
//  APIManager.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import Alamofire

typealias AFResult<T> = Result<T, Error>
protocol APIManager {
    func request( withEncodable: Bool, endpoint: APIEndpoint, result: @escaping (AFResult<APIResponse>) -> Void)
}
