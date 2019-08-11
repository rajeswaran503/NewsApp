//
//  NewsFeedEndPoint.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

public enum NewsFeedEndPoint{
    case getNewsFeed()
    
}

extension NewsFeedEndPoint:EndPointType {
    var baseURL: URL {
        guard let url = URL(string: AppConstant.Service.baseUrl) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .getNewsFeed:
            return AppConstant.Service.newsFeedApi
            
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .getNewsFeed:
            return .get
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .getNewsFeed :
            return .requestParametersAndHeaders(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: ["local":AppConstant.language], additionHeaders: ["consumer-secret":AppConstant.consumerSecret,"consumer-key":AppConstant.consumerKey])
            
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getNewsFeed:
            return nil
            
        }
    }
    
    
}
