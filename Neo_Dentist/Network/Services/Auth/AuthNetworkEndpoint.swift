//
//  AuthEndpoint.swift
//  Neo_Dentist
//
//  Created by Ravshan Winter on 22/12/23.
//

import Foundation
import Alamofire

enum AuthNetworkEndpoint: RESTEnpoint {
    case signUp(signUpReqest: SignUpRequest)
    case signIn(signInRequest: SignInRequest)
    case sendVerificationCode(sendVerificationRequest: SendVerificationCodeRequest)
    case verifyPassword(userID: Int, code: Int)
    case verifyPerson(userID: Int, code: Int)
    case passwordChange(passwordChangeRequest: PasswordChangeRequest)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .passwordChange:
            return .put
        default:
            return .post
        }
    }
    
    var parameters: Alamofire.Parameters? {
        switch self {
        default:
            return nil
        }
    }
    
    var encodableParameters: Encodable {
        switch self {
        case .signUp(let signUpReqest):
            return signUpReqest
        case .signIn(let signInRequest):
            return signInRequest
        case .sendVerificationCode(let request):
            return request
        case .verifyPassword(_, let code):
            let verifyCode = VerifyPaswordResetCode(code: code)
            return verifyCode
        case .verifyPerson(_, let code):
            let verifyCode = VerifyPaswordResetCode(code: code)
            return verifyCode
        case .passwordChange(let passwordChangeRequest):
            return passwordChangeRequest
        }
    }
    
    var encoder: Alamofire.JSONParameterEncoder {
        switch self {
        default:
            JSONParameterEncoder.default
        }
    }
    
    var url: String? {
        switch self {
        case .signUp:
            return "/users/register/"
        case .signIn:
            return "/users/login/"
        case .sendVerificationCode:
            return "/users/password/reset/"
        case .verifyPassword(let userID, _):
            return "/users/\(userID)/password/verify/"
        case .verifyPerson(let userID, _):
            return "/users/\(userID)/verify/"
        case .passwordChange:
            return "/users/password/change/"
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .passwordChange:
            let token = KeychainNeoDentist.getValue(key: KeychainConstants.accessToken)
            return ["Content-type": "application/json", "Authorization": "Bearer \(token!)"]
        default:
            return ["Content-type": "application/json"]
        }
        
    }
}
