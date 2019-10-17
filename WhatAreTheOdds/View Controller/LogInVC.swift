//
//  LogInVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    @IBOutlet weak var betTextView: UITextView!
    @IBOutlet weak var segueButton: UIButton!
    
    var placeholderLabel : UILabel!
    var tapGestHideKeys: UITapGestureRecognizer? = nil
    // MARK: - Life Cyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setUpTextFields()
        setUpBetView()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = ColorController.gameBoardBackground.value
        
        tapGestHideKeys = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let tapGestHideKeys = tapGestHideKeys {
            view.addGestureRecognizer(tapGestHideKeys)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let tapGestHideKeys = tapGestHideKeys {
            view.removeGestureRecognizer(tapGestHideKeys)
        }
    }
    
    // Hides the phone's status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setUpDummyPlayer() {
        // Test Case
        betTextView.text = "🏡🏡🏡🏡🏡🏡🏡"
        playerTwoTextField.text = "Sammy"
        playerOneTextField.text = "Tagger"
    }
    
    func setUpTextFields() {
        playerOneTextField.delegate = self
        playerTwoTextField.delegate = self
        
        playerTwoTextField.layer.cornerRadius = 4
        playerOneTextField.layer.cornerRadius = 4
    }
    
    func setUpBetView() {
        betTextView.delegate = self
        betTextView.returnKeyType = .done
        betTextView.layer.cornerRadius = 5
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
        
    }
    
    
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        betTextView.resignFirstResponder()
        playerOneTextField.resignFirstResponder()
        playerTwoTextField.resignFirstResponder()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playerOneName = playerOneTextField.text,
            let playerTwoName = playerTwoTextField.text,
            let bet = betTextView.text else { return  }
        
        guard let destinationVC = segue.destination as? GameBoardVC else {return}
        
        destinationVC.playerOneName = playerOneName
        destinationVC.playerTWoName = playerTwoName
        destinationVC.bet = bet
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let _ = (textField  === playerOneTextField) ? playerTwoTextField : playerOneTextField
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


