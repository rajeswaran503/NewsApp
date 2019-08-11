//
//  NewsFeed.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

struct NewsFeedResponse: Decodable {
    var success: Bool?
    var payload: [FeedDetails]?
}

struct FeedDetails: Decodable {
    var title: String?
    var description: String?
    var date: String?
    var image: String?
}
