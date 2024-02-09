//
//  AuthService.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 22/12/23.
//

import Foundation
import Alamofire

protocol AuthNetworkService {
    func sigIn(signInRequest: SignInRequest, callback: @escaping (Result<SignInResponse, Error>) -> Void)
    func sigUp(signUpRequestModel: SignUpRequest, callback: @escaping (Result<SignUpResponse, Error>) -> Void)
    func sendVerificationCode(sendVerificationRequest: SendVerificationCodeRequest, callback: @escaping (Result<SendVerificationCodeResponse, Error>) -> Void)
    func verifyPasswordVerificationCode(with userID: Int, code: Int, callback: @escaping (Result<CodeVerificationReponse, Error>) -> Void)
    func verifyPersonWithVerificationCode(with userID: Int, code: Int, callback: @escaping (Result<CodeVerificationReponse, Error>) -> Void)
    func changePassword(request: PasswordChangeRequest, callback: @escaping (Result<SuccessResponse, Error>) -> Void )
}

struct AuthServiceImplementation: AuthNetworkService {
    
    let apiManager: APIManager
    let mapper: JSONMapper
    
    init(apiManager: APIManager = RESTAPIManager(), mapper: JSONMapper = JSONMapperImplementation()) {
        self.apiManager = apiManager
        self.mapper = mapper
    }
    
    func sigUp(signUpRequestModel: SignUpRequest, callback: @escaping (Result<SignUpResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AuthNetworkEndpoint.signUp(signUpReqest: signUpRequestModel)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SignUpResponse.self))
        }
    }
    
    func sigIn(signInRequest: SignInRequest, callback: @escaping (Result<SignInResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AuthNetworkEndpoint.signIn(signInRequest: signInRequest)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SignInResponse.self))
        }
    }
    
    func sendVerificationCode(sendVerificationRequest: SendVerificationCodeRequest, callback: @escaping (Result<SendVerificationCodeResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AuthNetworkEndpoint.sendVerificationCode(sendVerificationRequest: sendVerificationRequest)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SendVerificationCodeResponse.self))
        }
    }
   
    func verifyPasswordVerificationCode(with userID: Int, code: Int, callback: @escaping (Result<CodeVerificationReponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AuthNetworkEndpoint.verifyPassword(userID: userID, code: code)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CodeVerificationReponse.self))
        }
    }
    
    func verifyPersonWithVerificationCode(with userID: Int, code: Int, callback: @escaping (Result<CodeVerificationReponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AuthNetworkEndpoint.verifyPerson(userID: userID, code: code)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: CodeVerificationReponse.self))
        }
    }
    
    func changePassword(request: PasswordChangeRequest, callback: @escaping (Result<SuccessResponse, Error>) -> Void) {
        apiManager.request(withEncodable: true, endpoint: AuthNetworkEndpoint.passwordChange(passwordChangeRequest: request)) { response in
            callback(mapper.mapToResult(from: response, forKey: nil, type: SuccessResponse.self))
        }
    }
}
