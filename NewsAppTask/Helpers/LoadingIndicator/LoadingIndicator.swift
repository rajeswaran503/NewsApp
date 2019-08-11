//
//  LoadingIndicator.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 11/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

class LoadingIndicator {
    
    
    static func show() {
        DispatchQueue.main.async {
            let activityIndicatorAlert = UIAlertController(title: NSLocalizedString("Loading", comment: ""), message: NSLocalizedString("PleaseWait", comment: "") + "...", preferredStyle: UIAlertController.Style.alert)
            activityIndicatorAlert.addActivityIndicator()
            var topController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
            while ((topController.presentedViewController) != nil) {
                topController = topController.presentedViewController!
            }
            topController.present(activityIndicatorAlert, animated:true, completion:nil)
        }
        
    }
    
   
    
    
   static func hide() {
     DispatchQueue.main.async {
        var topController:UIViewController = UIApplication.shared.keyWindow!.rootViewController!
        while ((topController.presentedViewController) != nil) {
            topController = topController.presentedViewController!
        }
        topController.dismiss(animated: true, completion: nil)
      }
    
    }
    
}


extension UIAlertController {
    
    private struct ActivityIndicatorData {
        static var activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    }
    
    func addActivityIndicator() {
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 40,height: 40)
        ActivityIndicatorData.activityIndicator.color = UIColor.blue
        ActivityIndicatorData.activityIndicator.startAnimating()
        vc.view.addSubview(ActivityIndicatorData.activityIndicator)
        self.setValue(vc, forKey: "contentViewController")
    }
    
    func dismissActivityIndicator() {
        ActivityIndicatorData.activityIndicator.stopAnimating()
        self.dismiss(animated: false)
    }
}
