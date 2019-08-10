//
//  TextFieldExtension.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

extension UITextField {
    
    func addBottomBorder(){
        removeExitingLayer(identifier: "bottomLine")
        let bottomLine = CALayer()
        bottomLine.name = "bottomLine"
        bottomLine.frame = CGRect.init(x: 0, y: self.frame.size.height - 1, width: self.frame.size.width, height: 1)
        bottomLine.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
        
    }
    
    func validatedText(validationType: ValidatorType) throws -> String {
        let validator = VaildatorFactory.validatorFor(type: validationType)
        return try validator.validated(self.text!)
    }
}

