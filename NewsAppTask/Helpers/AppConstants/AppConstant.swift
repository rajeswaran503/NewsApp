//
//  AppConstant.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

struct AppConstant {
    
    static let language = "en"
    static let consumerKey = "mobile_dev"
    static let consumerSecret = "20891a1b4504ddc33d42501f9c8d2215fbe85008"
    
    struct StoryBoardReference {
        static let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    }
    struct ViewControllerIdentifier{
        static let NewsFeedVC = "NewsFeedViewController"
        static let SignUpNC = "SignUP_NC"
    }
    
    struct Service {
        static let baseUrl = "https://api.qa.mrhe.gov.ae/mrhecloud/v1.4/api"
        static let registerApi = "/iskan/v1/certificates/towhomitmayconcern"
        static let newsFeedApi = "/public/v1/news"
        
    }
    
   
    
    struct AlertMessage {
        static let internetConnection = "Please check your internet connction."
    }
    
   
}


