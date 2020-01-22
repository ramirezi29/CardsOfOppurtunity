//
//  RulesVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 10/20/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class RulesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpView()
    }
    

    @IBAction func doneButtonTapped(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setUpView() {
         view.backgroundColor = ColorController.gameBoardBackground.value
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
