//
//  ConnectionLostAlertView.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 1/11/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import UIKit

class ConnectionLostAlertView: UIView {

    @IBOutlet weak var connectionStatusLabel: UILabel!
    @IBOutlet weak var errorActivtyIndicator: UIActivityIndicatorView!
    
    
    
    func showAlert() {
        updateConnectionAlert(notice: "Lost Internet Connection", color: ColorController.red.value, acitivtyIndShown: true, fadeIn: true)
    }

    
    func updateConnectionAlert(notice: String, color: UIColor, acitivtyIndShown: Bool, fadeIn: Bool) {
        DispatchQueue.main.async {
            self.connectionStatusLabel.text = notice
            self.errorActivtyIndicator.isHidden = acitivtyIndShown
        }
    }
}

