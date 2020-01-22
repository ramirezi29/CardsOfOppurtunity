//
//  BetVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 1/20/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import UIKit

class BetVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var instructionHeadingLabel: UILabel!
    @IBOutlet weak var customBetTextView: UITextView!
    @IBOutlet weak var customBetToggle: UISwitch!
    @IBOutlet weak var saveInstructionLabel: UILabel!
    @IBOutlet weak var nextButton: IRButton!
    
    var placeholderLabel : UILabel!
    var tapGestHideKeys: UITapGestureRecognizer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGestHideKeys = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        
        setUpBetView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let tapGestHideKeys = tapGestHideKeys {
            view.addGestureRecognizer(tapGestHideKeys)
        }
    }
    
    // TODO: - remove tap selector when not in use any more
    
    // Hides the phone's status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setUpBetView() {
        customBetTextView.delegate = self
        customBetTextView.returnKeyType = .done
        customBetTextView.layer.cornerRadius = 5
        // place holder
        customBetTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Example, Take out the trash 🗑'"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (customBetTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        customBetTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (customBetTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !customBetTextView.text.isEmpty
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            customBetTextView.resignFirstResponder()
            return false
        }
        return true
    }
    
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        customBetTextView.resignFirstResponder()
    }
}
