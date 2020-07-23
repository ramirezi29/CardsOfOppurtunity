//
//  GradientController.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 7/22/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import UIKit

extension UIView {
    
    /**
     An exention on UIView that renders a gradiant on a UIViewController
     */
    func verticleGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [
            #colorLiteral(red: 0.1803921569, green: 0.4901960784, blue: 0.1960784314, alpha: 1).cgColor,
            #colorLiteral(red: 0.3019607843, green: 0.7137254902, blue: 0.6745098039, alpha: 1).cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        
        self.layer.insertSublayer(gradient, at: 0)
    }
}
