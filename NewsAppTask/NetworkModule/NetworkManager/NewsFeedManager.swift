//
//  NewsFeedManager.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation


class NewsFeedManager: BaseNetworkManager {
    
    func getNewsFeed(onSuccess success: @escaping (_ response:NewsFeedResponse) -> Void, onFailure failure: @escaping (_ error:APIError) -> Void) {
        
        let router = NewsFeedEndPoint.getNewsFeed()
        baseServiceRequest(route: router, decoder: NewsFeedResponse.self) { response in
            switch response{
            case .success(let notifications):
                success(notifications)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
