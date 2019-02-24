//
//  ColorController.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/20/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

enum ColorController {
    
    case gameBoardBackground
    case buttonColor
    case deepPlum
    case offWhite
    case offWhiteLowAlpha
    case softGreen
    case blackGrey
    case annotationOrange
}

//Text Fields d1dfaf

extension ColorController {
    var value: UIColor {
        get {
            switch self {
            case .gameBoardBackground:
                return UIColor(red: 65/255, green: 152/255, blue: 82/255, alpha: 1.0)
            case .buttonColor:
                return UIColor(red: 233/255, green: 234/255, blue: 116/255, alpha: 1.0)
            case .deepPlum:
                return UIColor(red: 152/255, green: 65/255, blue: 151/255, alpha: 1.0)
            case .offWhite:
                return UIColor(red: 0.9569, green: 0.9647, blue: 0.9686, alpha: 1.0)
            case .softGreen:
                return UIColor(red: 17/255, green: 193/255, blue: 73/255, alpha: 1.0)
            case .offWhiteLowAlpha:
                return UIColor(red: 0.9569, green: 0.9647, blue: 0.9686, alpha: 5.0)
            case .blackGrey:
                return UIColor(red: 22/255, green: 21/255, blue: 20/255, alpha: 1.0)
            case .annotationOrange:
                return UIColor(red: 255/255, green: 73/255, blue: 42/255, alpha: 1.0)
            }
        }
    }
}
//Anotation ff492a
// complimentary #e66a54
/*
 Instead of textField.textColor = .black
 
 use:
 textField.backgroundColor = MyColor.blackGrey.value
 
 */

