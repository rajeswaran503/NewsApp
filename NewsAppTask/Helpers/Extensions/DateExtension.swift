//
//  DateExtension.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 12/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

extension Date {
    
    func getPastTime(for dateString : String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd'-'MM'-'yyyy'"
        let date = dateFormatter.date(from: dateString)
        var secondsAgo = Int(Date().timeIntervalSince(date ?? Date()))
        if secondsAgo < 0 {
            secondsAgo = secondsAgo * (-1)
        }
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute  {
            if secondsAgo < 2{
                return "just now"
            }else{
                return "\(secondsAgo) secs ago"
            }
        } else if secondsAgo < hour {
            let min = secondsAgo/minute
            if min == 1{
                return "\(min) min ago"
            }else{
                return "\(min) mins ago"
            }
        } else if secondsAgo < day {
            let hr = secondsAgo/hour
            if hr == 1{
                return "\(hr) hr ago"
            } else {
                return "\(hr) hrs ago"
            }
        } else if secondsAgo < week {
            let day = secondsAgo/day
            if day == 1{
                return "\(day) day ago"
            }else{
                return "\(day) days ago"
            }
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM dd, YYYY"
            formatter.locale = Locale(identifier: "en_US")
            let strDate: String = formatter.string(from: date ?? Date())
            return strDate
        }
    }
}
