//
//  LogInVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class LogInVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var playerOneTextField: UITextField!
    @IBOutlet weak var playerTwoTextField: UITextField!
    
    var tapGestHideKeys: UITapGestureRecognizer? = nil
    
    // MARK: - Life Cyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpTextFields()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
//        view.backgroundColor = ColorController.gameBoardBackground.value
         view.verticleGradient()
        
        tapGestHideKeys = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard(_:)))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        if let tapGestHideKeys = tapGestHideKeys {
            view.addGestureRecognizer(tapGestHideKeys)
        }
    }
    
    //TODO: - remove tap selector when not in use any more. Looks like its done here
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
        playerTwoTextField.text = "Sammy"
        playerOneTextField.text = "Tagger"
    }
    
    func setUpTextFields() {
        playerOneTextField.delegate = self
        playerTwoTextField.delegate = self
        
        playerTwoTextField.layer.cornerRadius = 4
        playerOneTextField.layer.cornerRadius = 4
    }
    
    @objc func hideKeyboard(_ sender: UITapGestureRecognizer) {
        //        betTextView.resignFirstResponder()
        playerOneTextField.resignFirstResponder()
        playerTwoTextField.resignFirstResponder()
    }
    
    
    
    // MARK: - Navigation
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        guard let playerOneName = playerOneTextField.text,
    //            let playerTwoName = playerTwoTextField.text,
    //            let bet = betTextView.text else { return  }
    //
    //        guard let destinationVC = segue.destination as? GameBoardVC else {return}
    //
    //        destinationVC.playerOneName = playerOneName
    //        destinationVC.playerTWoName = playerTwoName
    //        destinationVC.bet = bet
    //    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let _ = (textField  === playerOneTextField) ? playerTwoTextField : playerOneTextField
        playerTwoTextField.becomeFirstResponder()
        
        return true
    }
}


