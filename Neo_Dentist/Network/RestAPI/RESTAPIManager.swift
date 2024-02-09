//
//  RESTAPIManager.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 21/12/23.
//

import Foundation
import Alamofire

struct RESTAPIManager: APIManager {
    private func makeRequest(withEncodable: Bool, endpoint: APIEndpoint) -> DataRequest? {
        guard let endpoint = endpoint as? RESTEnpoint else { fatalError("invalid router type") }
        guard let path = endpoint.url, let url = URL(string: endpoint.baseURL + path) else { return nil }
        return withEncodable ? 
        AF.request(url, method: endpoint.method, parameters: endpoint.encodableParameters, encoder: endpoint.encoder, headers: endpoint.headers) :
        AF.request(url, method: endpoint.method, parameters: endpoint.parameters, headers: endpoint.headers)
    }
    
    func request( withEncodable: Bool, endpoint: APIEndpoint, result: @escaping (AFResult<APIResponse>) -> Void) {
        guard let request = makeRequest(withEncodable: withEncodable, endpoint: endpoint) 
        else {
            result(.failure(NetworkError.failedToMakeRequest))
            return
        }
            request
            .validate()
            .responseData { AFresponse in
                  if let error = AFresponse.error {
                      result(.failure(error));
                      return
                  }
                  switch AFresponse.result {
                  case .success(let data):
                      let resp = RESTAPIResponse(response: AFresponse.response, result: data, error: AFresponse.error)
                      result(.success(resp))
                  case .failure(let error):
                      result(.failure(error))
                  }
            }
    }
}
