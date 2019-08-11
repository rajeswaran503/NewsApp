//
//  SignUpEndPoint.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

public enum SignUpEndPoint{
    case registerUser(param:[String:Any])
    
}

extension SignUpEndPoint:EndPointType {
    var baseURL: URL {
        guard let url = URL(string: AppConstant.Service.baseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .registerUser:
            return AppConstant.Service.registerApi
        
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .registerUser:
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .registerUser(let param) :
           // return .requestParameters(bodyParameters: param, bodyEncoding: .formDataEncoding, urlParameters: nil)
           return .requestParametersAndHeaders(bodyParameters: param, bodyEncoding: .formDataEncoding, urlParameters: nil, additionHeaders: ["consumer-secret":"20891a1b4504ddc33d42501f9c8d2215fbe85008","consumer-key":"mobile_dev"])
        
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .registerUser:
            return nil//["consumer-secret":"20891a1b4504ddc33d42501f9c8d2215fbe85008","consumer-key":"mobile_dev"]
            
        }
    }
    
    
}
