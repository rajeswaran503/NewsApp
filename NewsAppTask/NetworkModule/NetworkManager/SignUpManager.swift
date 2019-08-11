//
//  SignUpManager.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

class SignUpManager: BaseNetworkManager {
    
    func signUp(userData:PersonData,onSuccess success: @escaping (_ response:PersonResponse) -> Void, onFailure failure: @escaping (_ error:APIError) -> Void) {
        
        
        let signUpParam:[String:Any] = ["eid":userData.empID ?? 0,
                                        "name":userData.name ?? "",
                                        "idbarahno":userData.idBarNo ?? 0,
                                        "emailaddress":userData.email ?? "",
                                        "unifiednumber":userData.uID ?? 0,
                                        "mobileno":userData.mobile ?? ""]
        let router = SignUpEndPoint.registerUser(param: signUpParam)
        baseServiceRequest(route: router, decoder: PersonResponse.self) { response in
            switch response{
            case .success(let notifications):
                success(notifications)
            case .failure(let error):
                failure(error)
            }
        }
    }
}
