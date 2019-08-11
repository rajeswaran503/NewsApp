//
//  NewsFeedViewModel.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

protocol NewsFeedViewModelDelegate: class {
    func successResponse(response:NewsFeedResponse)
    func alertMessage(message:String)
}
class NewsFeedViewModel {
    
    weak var delegate: NewsFeedViewModelDelegate?
    
    init() {
    }
    private func sendMessage(message:String) {
        if let _ = self.delegate {
            self.delegate?.alertMessage(message: message)
        }
    }
    func getNewsFeedData(fromRefresh:Bool = false) {
        if !Reachability.isConnectedToNetwork() {
            sendMessage(message: AppConstant.AlertMessage.internetConnection)
            return
        }
        if !fromRefresh {LoadingIndicator.show()}
        NewsFeedManager().getNewsFeed(onSuccess: { (response) in
            print(response)
            if response.success ?? false {
                if let _ = self.delegate {
                    self.delegate?.successResponse(response: response)
                }
            } else {
                self.sendMessage(message: "Something went wrong!")
            }
            LoadingIndicator.hide()
        }, onFailure: { (error) in
            LoadingIndicator.hide()
             self.sendMessage(message: error.localizedDescription)
            print(error)
        })
    }
}
