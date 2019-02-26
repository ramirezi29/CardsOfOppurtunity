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
    var screenTapped = false
    
    var p1RawScore = 0
    var p2RawScore = 0
    
    let networkErrorAlert = AlertController.presentAlertControllerWith(alertTitle: "Error Getting Your Cards", alertMessage: "Ensure you are connected to the internet and try again", dismissActionTitle: "OK")
    
    // Hides the phone's status bar
    override var prefersStatusBarHidden: Bool {
        return true
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
        let screenTapped = UITapGestureRecognizer(target: self, action: #selector(screenTapped(_:)))
        
        p1c1Gesture.numberOfTapsRequired = 1
        p1c2Gesture.numberOfTapsRequired = 1
        p1c3Gesture.numberOfTapsRequired = 1
        p2c1Gesture.numberOfTapsRequired = 1
        p2c2Gesture.numberOfTapsRequired = 1
        p2c3Gesture.numberOfTapsRequired = 1
        screenTapped.numberOfTapsRequired = 1
        
        p1DummyCard1Image.addGestureRecognizer(p1c1Gesture)
        p1DummyCard2Image.addGestureRecognizer(p1c2Gesture)
        p1DummyCard3Image.addGestureRecognizer(p1c3Gesture)
        
        p2DummyCard1Image.addGestureRecognizer(p2c1Gesture)
        p2DummyCard2Image.addGestureRecognizer(p2c2Gesture)
        p2DummyCard3Image.addGestureRecognizer(p2c3Gesture)
        view.addGestureRecognizer(screenTapped)
        
    }
    
    @objc func screenTapped(_ sender: UITapGestureRecognizer) {
        if screenTapped == false {
            screenTapped = true
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            var prefersStatusBarHidden: Bool {
                return false
            }
        } else {
            screenTapped = false
            self.navigationController?.setNavigationBarHidden(true, animated: true)
        }
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
            let unwrappedPlayerTwoName = playerTWoName else {return}
        
        switch unwrappedPlayerOneName {
        case "":
            playerNameOneLabel.text = "Player One"
        default:
            playerNameOneLabel.text = unwrappedPlayerOneName
        }
        
        switch unwrappedPlayerTwoName {
        case "":
            playerNameTwoLabel.text = "Player Two"
        default:
            playerNameTwoLabel.text = unwrappedPlayerTwoName
        }
        
//        let unwrappedBetText = bet
//        switch unwrappedBetText {
//        case "":
//            betTextLabel.text = "The odds were aginst you"
//        default:
//            betTextLabel.text = "Player \(unwrappedBetText)"
//        }
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
            
            if self.playerOneName == "" {
                self.playerNameOneLabel.text = "Player One"
            } else {
                self.playerNameOneLabel.text = "\(self.playerOneName ?? "Player One")"
            }
            
            if self.playerTWoName == "" {
                self.playerTWoName = "Player Two"
            } else {
                
                self.playerNameTwoLabel.text = "\(self.playerTWoName ?? "Player Two")"
            }
            self.p1HasSelectedCard = false
            self.p2HasSelectedCard = false
            self.drawButton.isUserInteractionEnabled = false
            self.playerOneScoreLabel.isHidden = false
            self.playerTwoScoreLabel.isHidden = false
            self.winnerLabel.isHidden = true
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
                                    
                                    self.playerOneCardImage.image = playerTwoCardImage
                                    
                                    self.playerTwoCardImage.image = playerOneCardImage
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
                    
                    // MARK: -  Outcome P1 Won
                    
                    
                    if  successfullCard![0].value > successfullCard![1].value
                    {
                        print("👠 Card 0: \(successfullCard![0].value) > Card 1: \(successfullCard![1].value)")
                        DispatchQueue.main.async {
                            self.userOneWon()
                            self.stopAnimatingCardXX()
                            
                            ScoreController.shared.playerOneScore += 1
                            self.playerOneScoreLabel.text = "\(ScoreController.shared.playerOneScore)"
                            ScoreController.drawAgainP1(playerOneScore: ScoreController.shared.playerOneScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            ScoreController.drawAgainP2(playerTwoScore: ScoreController.shared.playerOneScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            
                        }
                        print("\nPlayer #1 won\n")
                        
                        print("\nPlayer One raw score: \(self.p1RawScore)\n")
                        
                        // MARK: - Outcome P2 Won
                        
                    } else if successfullCard![0].value < successfullCard![1].value {
                        print("👗 Card 0:  \(successfullCard![0].value) < Card 1:  \(successfullCard![1].value)")
                        ScoreController.shared.playerTwoScore += 1
                        
                        DispatchQueue.main.async {
                            self.userTwoWon()
                            self.stopAnimatingCardXX()
                            

                            self.playerTwoScoreLabel.text = "\(ScoreController.shared.playerTwoScore)"
                            
                            ScoreController.drawAgainP1(playerOneScore: ScoreController.shared.playerTwoScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            
                            ScoreController.drawAgainP2(playerTwoScore: ScoreController.shared.playerTwoScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                        }
                        print("\nplayer #2 won\n")
                        print("\nPlayer Two raw score: \(ScoreController.shared.playerTwoScore)\n")
                        
                        // MARK: - Outcome Tie
                        
                    } else if successfullCard![0].value == successfullCard![1].value {
                        print("🧶Card 0: \(successfullCard![0].value) == Card 1:  \(successfullCard![1].value)")
                        ScoreController.shared.playerTwoScore += 0
                        ScoreController.shared.playerTwoScore += 0
                        self.stopAnimatingCardXX()
                        DispatchQueue.main.async {
                            self.drawButton.setTitle("Tie, Draw Again", for: .normal)
                            self.playerNameTwoLabel.text = "Tie"
                            self.playerNameOneLabel.text = "Tie"
                        }
                        print("Tie")
                    }
                    
                    if ScoreController.shared.playerOneScore == 2 {

                        ScoreController.shared.playerOneScore = 0
                        ScoreController.shared.playerTwoScore = 0
                        DispatchQueue.main.async {
      
                            self.playerOneScoreLabel.isHidden = true
                            self.playerTwoScoreLabel.isHidden = true
                            self.playerOneScoreLabel.text = "0"
                            self.playerTwoScoreLabel.text = "0"
                            self.drawButton.titleLabel?.text = "Play Again?"
                            self.userOneWonBet()
                            self.animateInVisualEffect()
                            self.userTwoWon()
                            
                            if self.playerOneName == "" {
                                self.winnerLabel.text =  "Player One Won!"
                                self.drawButton.titleLabel?.text = "Play Again?"
                            } else {
                                self.winnerLabel.text = "\(self.playerOneName ?? "Player One") Won!"
                                self.drawButton.setTitle("Play Again?", for: .normal)
                            }
                            self.winnerLabel.isHidden = false
                        }
                    }
                    //check if player two won - if it did reset the score for both playrs
                    if ScoreController.shared.playerTwoScore == 2 {
                        ScoreController.shared.playerOneScore = 0
                        ScoreController.shared.playerTwoScore = 0
                        DispatchQueue.main.async {
                            self.playerOneScoreLabel.isHidden = true
                            self.playerTwoScoreLabel.isHidden = true
                            self.playerTwoScoreLabel.text = "0"
                            self.playerOneScoreLabel.text = "0"
                            self.drawButton.setTitle("Play Again?", for: .normal)
                            self.userTwoWonBet()
                            self.animateInVisualEffect()
                            self.userTwoWon()
                            
                            if self.playerTWoName == "" {
                                self.winnerLabel.text =  "Player Two Won!"
                                self.drawButton.titleLabel?.text = "Play Again?"
                            } else {
                                self.winnerLabel.text = "\(self.playerTWoName ?? "Player Two") Won!"
                                self.drawButton.titleLabel?.text = "Play Again?"
                            }
                            self.winnerLabel.isHidden = false
                        }
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
        UserOneWonUI()
        switch playerOneName {
        case "":
            self.playerNameOneLabel.text = "Player One Won"
        default:
            self.playerNameOneLabel.text = "\(playerOneName ?? "Player One") Won"
            
            switch playerTWoName {
            case "":
                self.playerNameTwoLabel.text = "Player Two Lost"
            default:
                self.playerNameTwoLabel.text = "\(playerTWoName ?? "Player Two") Lost"
            }
        }
    }
    
    func userTwoWon(){
        UserTWOWonUI()
        switch playerTWoName {
        case "":
            self.playerNameTwoLabel.text = "Player Two Won"
        default:
            self.playerNameTwoLabel.text = "\(playerTWoName ?? "Player Two") Won"
            
            switch playerOneName {
            case "":
                self.playerNameOneLabel.text = "Player One Lost"
            default:
                self.playerNameOneLabel.text = "\(playerOneName ?? "Player One") Lost"
            }
        }
    }
    
    func resetGameBaord(){
        if self.drawButton.titleLabel?.text == "Draw Again" {
            DispatchQueue.main.async {
                self.cardDecksAppear()
            }
        }
    }
    
    func userOneWonBet() {
        playerNameTwoLabel.isHidden = true
        playerNameOneLabel.isHidden = true

        let unwrappedBetText = bet ?? "the odds were aginst you"
        switch unwrappedBetText {
        case "":
            if playerOneName == "" {
                betTextLabel.text = "Player Two lost, the odds were aginst you."
            } else {
                betTextLabel.text = "\(playerTWoName ?? "Player Two") \(unwrappedBetText)"
            }
        default:
            break
        }
    }
    
    func userTwoWonBet() {
        playerNameTwoLabel.isHidden = true
        playerNameOneLabel.isHidden = true
       
        let unwrappedBetText = bet ?? "the odds were aginst you"
        switch unwrappedBetText {
        case "":
            if playerOneName == "" {
                betTextLabel.text = "Player One lost, the odds were aginst you."
            } else {
                betTextLabel.text = "\(playerOneName ?? "Player Two") \(unwrappedBetText)"
            }
        default:
            break
        }
    }
    
    // MARK: - Font and Color for User Labels
    
    // Player One Won
    func UserOneWonUI(){
        self.playerNameOneLabel.textColor = UIColor(displayP3Red: 0, green: 0.7882, blue: 0.3255, alpha: 1.0)
        self.playerNameTwoLabel.textColor = UIColor(displayP3Red: 0.9686, green: 0.3059, blue: 0, alpha: 1.0)
        
    }
    
    // Player Two Won
    func UserTWOWonUI(){
        self.playerNameTwoLabel.textColor = UIColor(displayP3Red: 0, green: 0.7882, blue: 0.3255, alpha: 1.0)
        self.playerNameOneLabel.textColor = UIColor(displayP3Red: 0.9686, green: 0.3059, blue: 0, alpha: 1.0)
        
    }
}
