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

    //MARK: ViewController Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign Up"
        viewModel.delegate = self
        addKeyboardObserver()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        shadowSetup()
        textFieldUISetup()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: UI Design Methods
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
    
    //MARK: KeyBoard MoveUP/Down Methods
    func addKeyboardObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        if let textField = UIResponder.currentFirst() as? UITextField {
          
            let frame = textField.superview?.convert(textField.frame, to: nil) ?? CGRect()
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
               
                if keyboardSize.origin.y < frame.maxY {
                    let diff = (keyboardSize.origin.y - frame.maxY)
                    self.view.frame.origin.y += diff
                    
                }
              
            }
            
        }
        
       
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        
        self.view.frame.origin.y = 0
        
        
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
    
   
    //MARK: Button Action Methods
    @IBAction func registerButtonAction(sender: UIButton) {
        inputValidation()
    }
    
    
   
   
}

//MARK: ViewModel Delegate Methods
extension SignUpViewController: SiguUpViewModelDelegate {
    
    func successResponse(response: PersonResponse) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let nextVC = AppConstant.StoryBoardReference.main.instantiateViewController(withIdentifier: AppConstant.ViewControllerIdentifier.NewsFeedVC)
            self.navigationController?.pushViewController(nextVC, animated: false)
        }
        
        
    }
    func alertMessage(message: String) {
        DispatchQueue.main.async {
            self.showAlert(for: message)
            
        }
    }
    
    
}




