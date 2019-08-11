//
//  SiguUpViewModel.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import Foundation

protocol SiguUpViewModelDelegate: class {
    func successResponse(response:PersonResponse)
    func alertMessage(message:String)
}
class SiguUpViewModel {
    
    weak var delegate: SiguUpViewModelDelegate?
    
    init() {
        
    }
    
    
    private func sendMessage(message:String) {
            if let _ = self.delegate {
                self.delegate?.alertMessage(message: message)
            }
    }
    
   private func saveInLocal(userData:PersonData) {
         CoreDataManager.shared.savePerson(email: userData.email ?? "", empID: userData.empID ?? 0, idbarNo: userData.idBarNo ?? 0, mobile: userData.mobile ?? "", name: userData.name ?? "", uID: userData.uID ?? 0,refID: userData.refernceID ?? 0)
    }
    
    private func registerNewUser(userDetails:PersonData) {
        if !Reachability.isConnectedToNetwork() {
            sendMessage(message: AppConstant.AlertMessage.internetConnection)
            return
        }
        LoadingIndicator.show()
        SignUpManager().signUp(userData: userDetails, onSuccess: { (response) in
            LoadingIndicator.hide()
            if response.success ?? false {
                var user = userDetails
                user.refernceID = response.payload?.referenceNo ?? 0
                self.saveInLocal(userData: user)
                if let _ = self.delegate {
                    self.delegate?.successResponse(response: response)
                }
            } else {
                self.sendMessage(message: response.message ?? "")
                
            }
            print(response)
        }) { (error) in
            LoadingIndicator.hide()
           self.sendMessage(message: error.localizedDescription)
        }
        
    }
    
    func registerUserFormValidation(name: String,email: String,empID: String,mobileNo: String,uID: String,barNo: String) {
        do {
            let userNameValue = try name.validatedText(validationType: .username)
            let mobileNumber = try mobileNo.validatedText(validationType: .mobile)
            let emailValue = try email.validatedText(validationType: .email)
            let empIDValue = try empID.validatedText(validationType: .requiredField(field: "Employee ID"))
            let uIDValue = try uID.validatedText(validationType: .requiredField(field: "Unified Number"))
            let barahNo = try barNo.validatedText(validationType: .requiredField(field: "Barah Number"))
            var person = PersonData()
            person.name = userNameValue
            person.empID = Int(empIDValue)
            person.email = emailValue
            person.idBarNo = Int(barahNo)
            person.mobile =  mobileNumber
            person.uID = Int(uIDValue)
            registerNewUser(userDetails: person)
           
        } catch (let error) {
            print(error)
            if let validateError = error as? ValidationError {
                sendMessage(message: validateError.message)
               
            }
            
        }
    }
}
