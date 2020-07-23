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
    case red
    case green
    case betViewColor
    case winnerLabelGreen
}

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
            case .green:
                return UIColor(displayP3Red: 0, green: 0.7882, blue: 0.3255, alpha: 1.0)
            case .red:
                return UIColor(displayP3Red: 0.9686, green: 0.3059, blue: 0, alpha: 1.0)
            case .betViewColor:
               return UIColor(red: 36/255, green: 167/255, blue: 72/255, alpha: 1.0)
            case .winnerLabelGreen:
                return UIColor(red: 95/255, green: 199/255, blue: 39/255, alpha: 1.0)
            }
        }
    }
}
