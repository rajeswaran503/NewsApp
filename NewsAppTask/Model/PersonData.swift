//
//  PersonData.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

struct PersonData {
    var empID: Int?
    var name: String?
    var idBarNo: Int?
    var email: String?
    var uID: Int?
    var mobile: String?
    var refernceID: Int?
}

struct PersonResponse: Codable {
    var message: String?
    var success: Bool?
    var payload: PerosonRef?
}

struct PerosonRef: Codable {
    var referenceNo: Int?
}
