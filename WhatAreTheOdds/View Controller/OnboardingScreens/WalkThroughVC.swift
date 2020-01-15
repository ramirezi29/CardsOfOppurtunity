//
//  WalkThroughVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 1/14/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import UIKit

class WalkThroughVC: UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    var walkThroughPVC: WalkThroughPageVC?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
    }
    
    func updateUI() {
        if let index = walkThroughPVC?.currentIndex {
            
        }
    }

}
