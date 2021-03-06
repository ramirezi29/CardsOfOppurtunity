//
//  AlertController.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class AlertController {
    
    static func presentAlertControllerWith(alertTitle: String, alertMessage: String?, dismissActionTitle: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel, handler: nil)
        
        alertController.addAction(dismissAction)
        
        return alertController
    }
    
    
    static func presentActionSheetAlertControllerWith(alertTitle: String?, alertMessage: String?, dismissActionTitle: String) -> UIAlertController {
        
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .actionSheet)
        
        let dismissAction = UIAlertAction(title: dismissActionTitle, style: .cancel, handler: nil)
        
        alertController.addAction(dismissAction)
        
        return alertController
    }
}
