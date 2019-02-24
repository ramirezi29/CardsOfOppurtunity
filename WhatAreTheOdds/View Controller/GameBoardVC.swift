//
//  GameBoardVC.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit
import AVFoundation

class GameBoardVC: UIViewController{
    
    // MARK: - I disccounted the visual Blurr
    
    @IBOutlet weak var betDoneButton: UIButton!
    @IBOutlet var betView: UIView!
    
    @IBOutlet weak var betTextLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    
    @IBOutlet weak var playerOneCardImage: UIImageView!
    @IBOutlet weak var playerNameOneLabel: UILabel!
    @IBOutlet weak var playerNameTwoLabel: UILabel!
    @IBOutlet weak var playerTwoCardImage: UIImageView!
    
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    
    // player two dummy cards
    @IBOutlet weak var p2DummyCard1Image: UIImageView!
    @IBOutlet weak var p2DummyCard2Image: UIImageView!
    @IBOutlet weak var p2DummyCard3Image: UIImageView!
    
    // Player one dummy cards
    @IBOutlet weak var p1DummyCard1Image: UIImageView!
    @IBOutlet weak var p1DummyCard2Image: UIImageView!
    @IBOutlet weak var p1DummyCard3Image: UIImageView!
    
    // Draw Reset Button
    @IBOutlet weak var drawButton: IRButton!
    
    let backOfCardImage = UIImage(named: "backOfCard")
    
    var playerOneName: String?
    var playerTWoName: String?
    var bet: String?
    var effect: UIVisualEffect!
    
    // Controll flow properties
    var p1HasSelectedCard = false
    var p2HasSelectedCard = false
    var resetGameBoard = false
    
    var p1RawScore = 0
    var p2RawScore = 0
    
    let networkErrorAlert = AlertController.presentAlertControllerWith(alertTitle: "Error Getting Your Cards", alertMessage: "Ensure you are connected to the internet and try again", dismissActionTitle: "OK")
    
    // Hides the phone's status bar
    override var prefersStatusBarHidden: Bool {
        return false
    }
    // MARK: - Life Cyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI
        view.backgroundColor = ColorController.gameBoardBackground.value
        
        //Bet View
        betView.layer.cornerRadius = 5
        
        //Winner
        winnerLabel.isHidden = true
        
        // Label Names Update
        updateViews()
        
        //Cards Appear
        cardDecksAppear()
        
        // Score
        playerOneScoreLabel.text = "\(0)"
        playerTwoScoreLabel.text = "\(0)"
        
        drawButton.isHidden = true
        drawButton.alpha = 0.0
        drawButton.setTitle("Select Your Cards", for: .normal)
        drawButton.isUserInteractionEnabled = false
        
        // Hide Main Cards when app starts
        hidePlayersMainCards()
        
        //Bet Button UI
        betButtonUI()
        
        //Add guestures
        p1DummyCard1Image.isUserInteractionEnabled = true
        p1DummyCard2Image.isUserInteractionEnabled = true
        p1DummyCard3Image.isUserInteractionEnabled = true
        
        p2DummyCard1Image.isUserInteractionEnabled = true
        p2DummyCard2Image.isUserInteractionEnabled = true
        p2DummyCard3Image.isUserInteractionEnabled = true
        
        //P2
        let p1c1Gesture = UITapGestureRecognizer(target: self, action: #selector(p1c1Tapped(card1:)))
        let p1c2Gesture = UITapGestureRecognizer(target: self, action: #selector(p1c2Tapped(card2:)))
        let p1c3Gesture = UITapGestureRecognizer(target: self, action: #selector(p1c3Tapped(card3:)))
        
        //P2
        let p2c1Gesture = UITapGestureRecognizer(target: self, action: #selector(p2c1Tapped(card1:)))
        let p2c2Gesture = UITapGestureRecognizer(target: self, action: #selector(p2c2Tapped(card2:)))
        let p2c3Gesture = UITapGestureRecognizer(target: self, action: #selector(p2c3Tapped(card3:)))
        
        p1c1Gesture.numberOfTapsRequired = 1
        p1c2Gesture.numberOfTapsRequired = 1
        p1c3Gesture.numberOfTapsRequired = 1
        p2c1Gesture.numberOfTapsRequired = 1
        p2c2Gesture.numberOfTapsRequired = 1
        p2c3Gesture.numberOfTapsRequired = 1
        
        p1DummyCard1Image.addGestureRecognizer(p1c1Gesture)
        p1DummyCard2Image.addGestureRecognizer(p1c2Gesture)
        p1DummyCard3Image.addGestureRecognizer(p1c3Gesture)
        
        p2DummyCard1Image.addGestureRecognizer(p2c1Gesture)
        p2DummyCard2Image.addGestureRecognizer(p2c2Gesture)
        p2DummyCard3Image.addGestureRecognizer(p2c3Gesture)
        
    }
    
    // Player 1 Dummy Card Taps
    @objc func p1c1Tapped(card1: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            
            print("P1C1 Card Tapped")
            
            //            print("P1 C1 Y: \(self.p1DummyCard1Image.center.y)")
            //            print("P1 C1 X: \(self.p1DummyCard1Image.center.x)")
            
            if self.p1DummyCard1Image.center.y == 61.0 {
                self.p1HasSelectedCard = false
                self.updateDrawBttonView()
                print("P1 has selected a Card: \(self.p1HasSelectedCard)")
                DispatchQueue.main.async {
                    self.p1DummyCard1Image.center.y = 81.0
                }
            } else {
                self.p1HasSelectedCard = true
                self.updateDrawBttonView()
                print("P1 has selected a Card: \(self.p1HasSelectedCard)")
                DispatchQueue.main.async {
                    self.p1DummyCard1Image.center.y -= 20
                    self.p1DummyCard2Image.center.y = 81.0
                    self.p1DummyCard3Image.center.y = 81.0
                }
            }
        }
    }
    
    @objc func p1c2Tapped(card2: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            //            print("p1c2Tapped Card Tapped")
            if self.p1DummyCard2Image.center.y == 61.0 {
                self.p1HasSelectedCard = false
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p1DummyCard2Image.center.y = 81.0
                }
            } else {
                self.p1HasSelectedCard = true
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p1DummyCard2Image.center.y -= 20
                    self.p1DummyCard1Image.center.y = 81.0
                    self.p1DummyCard3Image.center.y = 81.0
                }
            }
        }
    }
    
    @objc func p1c3Tapped(card3: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            //            print("p1c3Tapped Card Tapped")
            if self.p1DummyCard3Image.center.y == 61.0 {
                self.p1HasSelectedCard = false
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p1DummyCard3Image.center.y = 81.0
                }
            } else {
                self.p1HasSelectedCard = true
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p1DummyCard3Image.center.y -= 20
                    self.p1DummyCard1Image.center.y = 81.0
                    self.p1DummyCard2Image.center.y = 81.0
                }
            }
        }
    }
    
    // P 2
    @objc func p2c1Tapped(card1: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            //            print("P2 C1 Y: \(self.p2DummyCard1Image.center.y)")
            //            print("P2 C1 X: \(self.p2DummyCard1Image.center.x)")
            if self.p2DummyCard1Image.center.y == 101.0 {
                print("P2 has selected a Card: \(self.p2HasSelectedCard)")
                self.p1HasSelectedCard = false
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p2DummyCard1Image.center.y = 81.0
                }
            } else {
                self.p2HasSelectedCard = true
                self.updateDrawBttonView()
                print("P2 has selected a Card: \(self.p2HasSelectedCard)")
                DispatchQueue.main.async {
                    self.p2DummyCard1Image.center.y += 20
                    self.p2DummyCard2Image.center.y = 81.0
                    self.p2DummyCard3Image.center.y = 81.0
                }
            }
        }
    }
    
    @objc func p2c2Tapped(card2: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            //            print("p2c2Tapped Card Tapped")
            if self.p2DummyCard2Image.center.y == 101.0 {
                self.p1HasSelectedCard = false
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p2DummyCard2Image.center.y = 81.0
                }
            } else {
                self.p2HasSelectedCard = true
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p2DummyCard2Image.center.y += 20
                    self.p2DummyCard1Image.center.y = 81.0
                    self.p2DummyCard3Image.center.y = 81.0
                }
            }
        }
    }
    
    @objc func p2c3Tapped(card3: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5) {
            //            print("p2c3Tapped Card Tapped")
            if self.p2DummyCard3Image.center.y == 101.0 {
                self.p1HasSelectedCard = false
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p2DummyCard3Image.center.y = 81.0
                }
            } else {
                self.p2HasSelectedCard = true
                self.updateDrawBttonView()
                DispatchQueue.main.async {
                    self.p2DummyCard3Image.center.y += 20
                    self.p2DummyCard1Image.center.y = 81.0
                    self.p2DummyCard2Image.center.y = 81.0
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideDummyCardsWithAlpha()
        
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - Animation
        cardDecksAppear()
        drawButtonAppears()
    }
    
    func updateViews() {
        guard let unwrappedPlayerOneName = playerOneName,
            let unwrappedPlayerTwoName = playerTWoName,
            
            let unwrappedBetText = bet else {return}
        playerNameOneLabel.text = unwrappedPlayerOneName
        playerNameTwoLabel.text = unwrappedPlayerTwoName
        
        betTextLabel.text = "Player \(unwrappedBetText)"
    }
    
    
    // MARK: - Actions
    
    @IBAction func betDoneButtonTapped(_ sender: Any) {
        animateOutOfBetView()
    }
    
    func animateOutOfBetView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.betView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.betView.alpha = 0
        }) { (success: Bool) in
            self.betView.removeFromSuperview()
        }
    }
    
    func betButtonUI() {
        betDoneButton.layer.borderWidth = 4
        betDoneButton.layer.borderColor = UIColor.cyan.cgColor
        betDoneButton.layer.cornerRadius = betDoneButton.frame.height / 4
    }
    
    // Visual Effect
    func animateInVisualEffect() {
        
        self.view.addSubview(self.betView)
        self.betView.center = self.view.center
        
        self.betView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.betView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.betView.alpha = 1
            self.betView.transform =  CGAffineTransform.identity
        }
    }
    
    func p1SelectedCardCheker() {
        switch p1HasSelectedCard {
        case false:
            p1HasSelectedCard = true
        case true:
            p1HasSelectedCard = false
        }
    }
    
    func p2SelectedCardCheker() {
        switch p2HasSelectedCard {
        case false:
            p2HasSelectedCard = true
        case true :
            p2HasSelectedCard = false
        }
    }
    
    func hidePlayersMainCards() {
        self.playerOneCardImage.isHidden = true
        self.playerTwoCardImage.isHidden = true
    }
    
    func showPlayersMainCards() {
        self.playerOneCardImage.isHidden = false
        self.playerTwoCardImage.isHidden = false
    }
    
    func hideDummyCards(){
        self.p1DummyCard1Image.isHidden = true
        self.p1DummyCard2Image.isHidden = true
        self.p1DummyCard3Image.isHidden = true
        
        // Player Two
        self.p2DummyCard1Image.isHidden = true
        self.p2DummyCard2Image.isHidden = true
        self.p2DummyCard3Image.isHidden = true
    }
    
    func showDummyCards(){
        self.p1DummyCard1Image.isHidden = false
        self.p1DummyCard2Image.isHidden = false
        self.p1DummyCard3Image.isHidden = false
        
        // Player Two
        self.p2DummyCard1Image.isHidden = false
        self.p2DummyCard2Image.isHidden = false
        self.p2DummyCard3Image.isHidden = false
    }
    
    func hideDummyCardsWithAlpha() {
        // Dummy cards dissappear
        // Player One
        self.p1DummyCard1Image.alpha = 0.0
        self.p1DummyCard2Image.alpha = 0.0
        self.p1DummyCard3Image.alpha = 0.0
        
        // Player Two
        self.p2DummyCard1Image.alpha = 0.0
        self.p2DummyCard2Image.alpha = 0.0
        self.p2DummyCard3Image.alpha = 0.0
    }
}

extension GameBoardVC {
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    @IBAction func drawButtonTapped(_ sender: IRButton) {
        if resetGameBoard == false {
            resetGameBoard = true
            DispatchQueue.main.async {
                self.hideDummyCards()
                self.showPlayersMainCards()
                self.playerOneScoreLabel.isHidden = false
                self.playerTwoScoreLabel.isHidden = false
               
                //self.startAnimatingCardXX()
            }
            self.fetchNewCard()
        }else {
            resetGameBoard = false
            self.playerNameOneLabel.text = "\(self.playerOneName ?? "Player One")"
            self.playerNameTwoLabel.text = "\(self.playerTWoName ?? "Player Two")"
            self.p1HasSelectedCard = false
            self.p2HasSelectedCard = false
            self.drawButton.isUserInteractionEnabled = false
            self.playerOneScoreLabel.isHidden = false
            self.playerTwoScoreLabel.isHidden = false
            self.drawButton.setTitle("Select Your Cards", for: .normal)
            self.hidePlayersMainCards()
            self.showDummyCards()
            self.cardDecksAppear()
        }
    }
}

extension GameBoardVC {
    func fetchNewCard() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        CardController.fetchCards(amount: 2) { (successfullCard, error) in
            
            if (successfullCard != nil) {
                
                // if successful
                CardController.fetchImagesFor(card: (successfullCard![0] ), completion: { (playerOneCardImage, error) in
                    
                    if (successfullCard != nil) {
                        
                        CardController.fetchImagesFor(card: successfullCard![1], completion: { (playerTwoCardImage, error) in
                            
                            DispatchQueue.main.async {
                                if (successfullCard != nil) {
                                    
                                    self.playerOneCardImage.image = playerOneCardImage
                                    
                                    self.playerTwoCardImage.image = playerTwoCardImage
                                } else {
                                    self.stopAnimatingCardXX()
                                    self.present(self.networkErrorAlert, animated: true, completion: nil)
                                }
                            }
                        })
                    } else {
                        DispatchQueue.main.async {
                            self.stopAnimatingCardXX()
                            self.present(self.networkErrorAlert, animated: true, completion: nil)
                        }
                    }
                    guard successfullCard != nil else {return}
                    if  successfullCard![0].value > successfullCard![1].value
                    {
                        DispatchQueue.main.async {
                            self.userOneWon()
                            self.stopAnimatingCardXX()
                            
                            ScoreController.shared.playerTwoScore += 1
                            self.p1RawScore = self.p1RawScore + 1
                            self.playerOneScoreLabel.text = "\(self.p1RawScore)"
                            ScoreController.drawAgainP1(playerOneScore: self.p1RawScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            ScoreController.drawAgainP2(playerTwoScore: self.p1RawScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            
                            print("\nPlayer #1 won\n")
                        }
                    } else if successfullCard![0].value < successfullCard![1].value {
                        DispatchQueue.main.async {
                            self.userTwoWon()
                            self.stopAnimatingCardXX()
                            
                            ScoreController.shared.playerTwoScore += 1
                            self.p2RawScore = self.p2RawScore + 1
                            self.playerTwoScoreLabel.text = "\(self.p2RawScore)"
                            
                            ScoreController.drawAgainP1(playerOneScore: self.p1RawScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            ScoreController.drawAgainP2(playerTwoScore: self.p1RawScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            print("\nplayer #2 won\n")
                        }
                    } else if successfullCard![0].value == successfullCard![1].value {
                        self.stopAnimatingCardXX()
                        DispatchQueue.main.async {
                            self.drawButton.setTitle("Tie, Draw Again", for: .normal)
                            self.playerNameTwoLabel.text = "Tie"
                            self.playerNameOneLabel.text = "Tie"
                        }
                        print("Tie")
                    }
                    //check if player one won - if it did reset the score for both playrs
                    if ScoreController.shared.playerOneScore == 2 {
                        //present NewView
                        DispatchQueue.main.async {
                            self.playerOneScoreLabel.text = "0"
                            self.playerTwoScoreLabel.text = "0"
                            
                            self.drawButton.titleLabel?.text = "Play Again?"
                            self.p1RawScore = 0
                            self.p2RawScore = 0
                            
                            self.animateInVisualEffect()
                            self.userTwoWon()
                            self.winnerLabel.isHidden = false
                            
                            if self.playerOneName == "" {
                                self.winnerLabel.text =  "Player One Won!"
                            } else {
                                self.winnerLabel.text = "\(self.playerOneName ?? "Player One") Won!"
                            }
                        }
                        ScoreController.shared.playerOneScore = 0
                        ScoreController.shared.playerTwoScore = 0
                    }
                    //check if player two won - if it did reset the score for both playrs
                    if ScoreController.shared.playerTwoScore == 2 {
                        
                        DispatchQueue.main.async {
                            self.drawButton.titleLabel?.text = "Play Again?"
                            
                            self.playerTwoScoreLabel.text = "0"
                            self.playerOneScoreLabel.text = "0"
                            
                            self.p1RawScore = 0
                            self.p2RawScore = 0
                            
                            self.animateInVisualEffect()
                            self.userTwoWon()
                            self.winnerLabel.isHidden = false
                            
                            if self.playerOneName == "" {
                                self.winnerLabel.text =  "Player Two Won!"
                            } else {
                                self.winnerLabel.text = "\(self.playerTWoName ?? "Player Two") Won!"
                            }
                        }
                        ScoreController.shared.playerOneScore = 0
                        ScoreController.shared.playerTwoScore = 0
                    }
                })
            } else {
                // if failed fetching two cards
                DispatchQueue.main.async {
                    self.stopAnimatingCardXX()
                    self.present(self.networkErrorAlert, animated: true, completion: nil)
                }
            }
        }
    }
}

extension GameBoardVC {
    func startAnimatingCardXX() {
        playerOneCardImage.spin()
        playerTwoCardImage.spin()
    }
    
    func stopAnimatingCardXX() {
        playerTwoCardImage.stopRotating()
        playerOneCardImage.stopRotating()
    }
}

// MARK: - aniamtions
extension GameBoardVC {
    
    func updateDrawBttonView() {
        if p1HasSelectedCard && p2HasSelectedCard == true {
            self.drawButton.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.drawButton.setTitle("Draw", for: .normal)
                }
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                DispatchQueue.main.async {
                    self.drawButton.isUserInteractionEnabled = false
                    self.drawButton.setTitle("Select Your Cards", for: .normal)
                }
            }
        }
    }
    
    func cardDecksAppear() {
        
        // Cards appear
        UIImageView .animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.p1DummyCard1Image.alpha = CGFloat(1.0)
        }, completion: nil)
        
        UIImageView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.p1DummyCard2Image.alpha = CGFloat(1.0)
        }, completion: nil)
        
        UIImageView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
            self.p1DummyCard3Image.alpha = CGFloat(1.0)
        }, completion: nil)
        
        UIImageView .animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.p2DummyCard1Image.alpha = CGFloat(1.0)
        }, completion: nil)
        
        UIImageView.animate(withDuration: 0.5, delay: 0.7, options: [], animations: {
            self.p2DummyCard2Image.alpha = CGFloat(1.0)
        }, completion: nil)
        
        UIImageView.animate(withDuration: 0.5, delay: 0.9, options: [], animations: {
            self.p2DummyCard3Image.alpha = CGFloat(1.0)
        }, completion: nil)
    }
    
    func drawButtonAppears() {
        UIView.animate(withDuration: 0.5, delay: 1.0, options: [], animations: {
            self.drawButton.isHidden = false
            self.drawButton.alpha = 1
        }, completion: nil)
    }
    
    func drawAgain(){
        self.drawButton.setTitle("Draw Again", for: .normal)
    }
    
    func userOneWon() {
        self.playerNameOneLabel.text = "\(playerOneName ?? "Player One") Won"
        self.playerNameTwoLabel.text = "\(playerTWoName ?? "Player Two") Lost"
        UserOneWonUI()
    }
    
    func userTwoWon(){
        self.playerNameOneLabel.text = "\(playerOneName ?? "Player One") Lost"
        self.playerNameTwoLabel.text = "\(playerTWoName ?? "Player Two") Won"
        UserTWOWonUI()
    }
    
    func resetGameBaord(){
        if self.drawButton.titleLabel?.text == "Draw Again" {
            DispatchQueue.main.async {
                self.cardDecksAppear()
            }
        }
    }
    
    // MARK: - Font and Color for User Labels
    
    // User One Won
    func UserOneWonUI(){
        self.playerNameOneLabel.textColor = UIColor(displayP3Red: 0, green: 0.7882, blue: 0.3255, alpha: 1.0)
        self.playerNameOneLabel.font = UIFont(name: "PingFangSC-Medium ", size: 14)
        
        self.playerNameTwoLabel.textColor = UIColor(displayP3Red: 0.9686, green: 0.3059, blue: 0, alpha: 1.0)
        self.playerNameTwoLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
    }
    
    // User Two Won
    func UserTWOWonUI(){
        self.playerNameTwoLabel.textColor = UIColor(displayP3Red: 0, green: 0.7882, blue: 0.3255, alpha: 1.0)
        self.playerNameTwoLabel.font = UIFont(name: "PingFangSC-Medium ", size: 14)
        
        //
        self.playerNameOneLabel.textColor = UIColor(displayP3Red: 0.9686, green: 0.3059, blue: 0, alpha: 1.0)
        self.playerNameOneLabel.font = UIFont(name: "PingFangSC-Regular", size: 14)
    }
}
