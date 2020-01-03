//
//  UIView+Extensions.swift
//  Song Studio
//
//  Created by Catherine K G on 17/11/19.
//  Copyright © 2019 Catherine. All rights reserved.
//

import UIKit

extension UIView {
    func applyShadowAndCorner() {
        self.layer.cornerRadius = 30
        self.clipsToBounds = true
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.applyShadow()
    }
    
    func applyShadow() {
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.3, height: 0.2)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4.0
        self.layer.masksToBounds =  false
    }
    
    func gradientWith(topColor: UIColor, bottomColor: UIColor){
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        gradientLayer.colors = [(topColor.cgColor), (bottomColor.cgColor)]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

