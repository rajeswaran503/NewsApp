//
//  UIViewExtension.swift
//  NewsAppTask
//
//  Created by Rajeswaran on 10/08/19.
//  Copyright © 2019 Rajes. All rights reserved.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, shadowRadius: CGFloat = 1, scale: Bool = true, cornerRadius: CGFloat) {
        
        removeExitingLayer(identifier:"shadow")
        let shadowLayer = CAShapeLayer()
        shadowLayer.name = "shadow"
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
        shadowLayer.fillColor = UIColor.primaryColor().cgColor//UIColor.clear.cgColor
        shadowLayer.shadowColor = color.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = offSet
        shadowLayer.shadowOpacity = opacity
        shadowLayer.shadowRadius = shadowRadius
        layer.insertSublayer(shadowLayer, at: 0)
    }
    
        
        func removeExitingLayer(identifier:String) {
            if let sLayers = self.layer.sublayers {
                for exiting in sLayers where exiting.name == identifier {
                    exiting.removeFromSuperlayer()
                }
            }
        }

}
