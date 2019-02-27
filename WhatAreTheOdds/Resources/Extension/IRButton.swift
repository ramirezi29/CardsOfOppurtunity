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
        setTitleColor(.black, for: .normal)
        backgroundColor = ColorController.buttonColor.value
        titleLabel?.font = .boldSystemFont(ofSize: 24)
        layer.cornerRadius = frame.size.height / 4
    }
}
