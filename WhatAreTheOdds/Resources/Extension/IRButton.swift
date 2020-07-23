//
//  IRButton.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/20/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class IRButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    private func setupButton() {
        let gradient = CAGradientLayer()
                      gradient.frame = self.bounds
                      gradient.colors = [
                          #colorLiteral(red: 1, green: 0.5607843137, blue: 0, alpha: 1).cgColor,
                          #colorLiteral(red: 1, green: 0.9254901961, blue: 0.7019607843, alpha: 1).cgColor
                      ]
               
               gradient.startPoint = CGPoint(x: 0, y: 0)
                     gradient.endPoint = CGPoint(x: 1, y: 1)
               
               setTitleColor(.white, for: .normal)
//               layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
//               layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
//               layer.shadowOpacity = 1.0
               layer.shadowRadius = 5.0
               layer.masksToBounds = true
               
               layer.insertSublayer(gradient, at: 0)
               
                   
                   
               titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium)
               layer.cornerRadius = frame.size.height / 5
    }
}
