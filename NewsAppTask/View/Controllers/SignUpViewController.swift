//
//  SignUpViewController.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var mobileTextField: UITextField!
    
    @IBOutlet weak var employeeIDTextField: UITextField!
    
    @IBOutlet weak var idBarahNoTextField: UITextField!
    
    @IBOutlet weak var unifiedNumberTextField: UITextField!
    
    @IBOutlet weak var inputFieldContentView: UIView!
    
    @IBOutlet weak var registerButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let person = CoreDataManager.shared.fetchPerson()
        print(person)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shadowSetup()
        textFieldUISetup()
        
        
    }
    
    
    func shadowSetup() {
        registerButton.dropShadow(color: .lightGray, offSet: CGSize(width: 1, height: 1), cornerRadius: registerButton.frame.size.height)
        inputFieldContentView.dropShadow(color: .lightGray, offSet: CGSize.zero, cornerRadius: 10)
    }
    
    func textFieldUISetup() {
        nameTextField.addBottomBorder()
        mobileTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        emailTextField.addBottomBorder()
        idBarahNoTextField.addBottomBorder()
        unifiedNumberTextField.addBottomBorder()
        employeeIDTextField.addBottomBorder()
    }
    
    func inputValidation() {
        do {
            let userName = try nameTextField.validatedText(validationType: .username)
            let mobileNumber = try mobileTextField.validatedText(validationType: .mobile)
           let email = try emailTextField.validatedText(validationType: .email)
           let empID = try employeeIDTextField.validatedText(validationType: .requiredField(field: "Employee ID"))
            let uID = try unifiedNumberTextField.validatedText(validationType: .requiredField(field: "Unified Number"))
            let barahNo = try idBarahNoTextField.validatedText(validationType: .requiredField(field: "Barah Number"))
            CoreDataManager.shared.savePerson(email: email, empID: Int(empID) ?? 0, idbarNo: Int(barahNo) ?? 0, mobile: Int( mobileNumber) ?? 0, name: userName, uID: Int(uID) ?? 0)
        } catch (let error) {
            print(error)
            if let validateError = error as? ValidationError {
                showAlert(for: validateError.message)
            }
           
        }
    }
    @IBAction func registerButtonAction(sender: UIButton) {
        inputValidation()
    }

}


