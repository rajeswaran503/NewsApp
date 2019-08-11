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
    
    lazy var viewModel: SiguUpViewModel = {
        let vm = SiguUpViewModel()
        return vm
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        viewModel.delegate = self
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
        let emailValue = emailTextField.text ?? ""
        let nameValue = nameTextField.text ?? ""
        let mobileNo = mobileTextField.text ?? ""
        let empId = employeeIDTextField.text ?? ""
        let uId = unifiedNumberTextField.text ?? ""
        let barNoData = idBarahNoTextField.text ?? ""
        viewModel.registerUserFormValidation(name: nameValue, email: emailValue, empID: empId, mobileNo: mobileNo, uID: uId, barNo: barNoData)

    }
    
   
    @IBAction func registerButtonAction(sender: UIButton) {
        inputValidation()
    }
    
    
   
   
}


extension SignUpViewController: SiguUpViewModelDelegate {
    
    func successResponse(response: PersonResponse) {
        
    }
    func alertMessage(message: String) {
        DispatchQueue.main.async {
            self.showAlert(for: message)
            
        }
    }
    
    
}



