//
//  LogInVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var playeOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var betTextView: UITextView!
    @IBOutlet weak var segueButton: UIButton!
    
    // Hides the phone's status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBOutlet var textView : UITextView!
    
    var placeholderLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Test Case
        //betTextView.text = "🏡🏡🏡🏡🏡🏡🏡"
        //playerTwoTextField.text = "Sammy"
        //playeOneTextField.text = "Tagger"
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        //UI
        view.backgroundColor = ColorController.gameBoardBackground.value
        // navigation
        
        // Delegate declaration
        self.playeOneTextField.delegate = self
        self.playerTwoTextField.delegate = self
        
        // Bet textView
        self.betTextView.delegate = self
        self.betTextView.returnKeyType = .done
        
        //Tap G
        let hideKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        
        view.addGestureRecognizer(hideKeyboardTap)
        
        // place holder
        betTextView.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Example, Take out the trash 🗑'"
        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (betTextView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        betTextView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (betTextView.font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !betTextView.text.isEmpty
        
        playerTwoTextField.layer.cornerRadius = 4
        playerTwoTextField.layer.cornerRadius = 4
        betTextView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        betTextView.resignFirstResponder()
        playeOneTextField.resignFirstResponder()
        playerTwoTextField.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerOneName = playeOneTextField.text,
            let playerTwoName = playerTwoTextField.text,
            let bet = betTextView.text else { return  }
        
        guard let destinationVC = segue.destination as? GameBoardVC else {return}
        
        destinationVC.playerOneName = playerOneName
        destinationVC.playerTWoName = playerTwoName
        destinationVC.bet = bet
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let _ = (textField  === playeOneTextField) ? playerTwoTextField : playeOneTextField
        playerTwoTextField.becomeFirstResponder()
        
        return true
    }
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            betTextView.resignFirstResponder()
            return false
        }
        return true
    }
}


