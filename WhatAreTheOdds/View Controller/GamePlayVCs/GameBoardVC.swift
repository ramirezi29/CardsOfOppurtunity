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
    
    @IBOutlet var betView: UIView!
    @IBOutlet weak var betDoneButton: IRButton!
    @IBOutlet weak var drawButton: IRButton!
    @IBOutlet weak var betTextLabel: UILabel!
    @IBOutlet weak var winnerLabel: UILabel!
    @IBOutlet weak var playerNameOneLabel: UILabel!
    @IBOutlet weak var playerNameTwoLabel: UILabel!
    @IBOutlet weak var playerOneCardImage: UIImageView!
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
    
    var playerOneName: String?
    var playerTWoName: String?
    var bet: String?
    var effect: UIVisualEffect!
    
    // Controll flow properties
    var p1HasSelectedCard = false
    var p2HasSelectedCard = false
    var resetGameBoard = false
    var screenTapped = false
    
    let backOfCardImage = UIImage(named: "backOfCard")
    
    let networkErrorAlert = AlertController.presentAlertControllerWith(alertTitle: "Error Getting Your Cards", alertMessage: "Ensure you are connected to the internet and try again", dismissActionTitle: "OK")
    
    var connectionLostAlert: ConnectionLostAlertView?
    
    // Hides the phone's status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //    func presentNetworkErrorAlertFunc() {
    //
    //        let networkErrorAlert = AlertController.presentAlertControllerWith(alertTitle: "Error Getting Your Cards", alertMessage: "Ensure you are connected to the internet and try again", dismissActionTitle: "OK")
    //        let imageView = UIImageView(frame: CGRect(x: 220, y: 10, width: 50, height: 50))
    //        imageView.image = UIImage(named: "warning")
    //
    //        networkErrorAlert.view.addSubview(imageView)
    //        self.present(networkErrorAlert, animated: true)
    //    }
    
    // MARK: - Life Cyles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // UI
        view.backgroundColor = ColorController.gameBoardBackground.value
        
        //Bet View
        betView.layer.cornerRadius = 5
        
        //Winner
        winnerLabel.backgroundColor = ColorController.winnerLabelGreen.value
        winnerLabel.layer.cornerRadius = 4
        winnerLabel.isHidden = true
        
        // Label Names Update
        updateViews()
        
        //Cards Appear
        dummyCardDecksAppear()
        
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
        
        // NOTE: - In order to reset the score board under the hood
        ScoreController.shared.playerOneScore = 0
        ScoreController.shared.playerTwoScore = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - Animation
        dummyCardDecksAppear()
        drawButtonAppears()
    }
    
    func updateViews() {
        
        guard let unwrappedPlayerOneName = playerOneName,
            let unwrappedPlayerTwoName = playerTWoName,
            let betOnTheTable = bet else {return}
        
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
        
        switch betOnTheTable {
        case "":
            betTextLabel.text = "The odds were not in your favor, you lost."
        default:
            betTextLabel.text = betOnTheTable
        }
    }
    
    // MARK: - Actions
    
    @IBAction func betDoneButtonTapped(_ sender: IRButton) {
        animateOutOfBetView()
    }
    
    func betButtonUI() {
        betDoneButton.layer.borderWidth = 4
        betDoneButton.layer.borderColor = UIColor.black.cgColor
        betDoneButton.layer.cornerRadius = betDoneButton.frame.height / 4
    }
    
    
    // MARK: - Bet View
    
    func animateOutOfBetView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.betView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            self.betView.alpha = 0
        }) { (success: Bool) in
            self.betView.removeFromSuperview()
        }
    }
    
    func animateInBetView() {
        self.view.addSubview(self.betView)
        self.betView.backgroundColor = ColorController.betViewColor.value
        self.betView.layer.borderWidth = 4
        self.betView.layer.borderColor = UIColor.black.cgColor
        self.betView.center = self.view.center
        
        self.betView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        self.betView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.betView.alpha = 1
            self.betView.transform =  CGAffineTransform.identity
        }
    }
    
    // MARK: - Show and hide objects
    
    // Main cards
    func hidePlayersMainCards() {
        self.playerOneCardImage.isHidden = true
        self.playerTwoCardImage.isHidden = true
        self.playerTwoCardImage.image = backOfCardImage
        self.playerOneCardImage.image = backOfCardImage
    }
    
    func showPlayersMainCards() {
        self.playerOneCardImage.isHidden = false
        self.playerTwoCardImage.isHidden = false
    }
    
    // Score label
    func hidePlayerScoreLabels() {
        self.playerOneScoreLabel.isHidden = true
        self.playerTwoScoreLabel.isHidden = true
    }
    
    func showPlayerScoreLabels() {
        self.playerOneScoreLabel.isHidden = false
        self.playerTwoScoreLabel.isHidden = false
    }
    
    // Player name Label
    func showPlayerNameLabels() {
        self.playerNameOneLabel.isHidden = false
        self.playerNameTwoLabel.isHidden = false
    }
    
    func hidePlayerNameLabels() {
        self.playerNameOneLabel.isHidden = false
        self.playerNameTwoLabel.isHidden = false
    }
    
    // Dummy card decks
    
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
                self.showPlayerScoreLabels()
                self.showPlayerNameLabels()
                self.UserOneAndTwoBlackLabelColorUI()
                //Future features
                //self.startAnimatingCardXX()
            }
            self.fetchNewCard()
        }else {
            resetGameBoard = false
            self.UserOneAndTwoBlackLabelColorUI()
            
            if self.playerOneName == "" {
                self.playerNameOneLabel.text = "Player One"
            } else {
                self.playerNameOneLabel.text = "\(self.playerOneName ?? "Player One")"
            }
            
            if self.playerTWoName == "" {
                self.playerTWoName = "Player Two"
            } else {
                self.playerNameTwoLabel.text = "\(self.playerTWoName ?? "🗑 Player Two")"
            }
            
            self.p1HasSelectedCard = false
            self.p2HasSelectedCard = false
            self.drawButton.isUserInteractionEnabled = false
            self.showPlayerScoreLabels()
            self.winnerLabel.isHidden = true
            self.drawButton.setTitle("Select Your Cards", for: .normal)
            self.hidePlayersMainCards()
            self.showDummyCards()
            self.dummyCardDecksAppear()
        }
    }
}

extension GameBoardVC {
    func fetchNewCard() {
        AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
        
        CardController.fetchCards(amount: 2) { (successfullCard, error) in
            
            if (successfullCard != nil) {
                
                CardController.fetchImagesFor(card: (successfullCard![0] ), completion: { (playerOneCardImage, error) in
                    
                    if (successfullCard != nil) {
                        
                        CardController.fetchImagesFor(card: successfullCard![1], completion: { (playerTwoCardImage, error) in
                            
                            DispatchQueue.main.async {
                                if (successfullCard != nil) {
                                    
                                    self.playerOneCardImage.image = playerOneCardImage
                                    
                                    self.playerTwoCardImage.image = playerTwoCardImage
                                } else {
                                    // Future Feature wiht Sping Animation
                                    //self.stopAnimatingCardXX()
//                                    self.playerCardsBackSide()
                                    
                                    self.present(self.networkErrorAlert, animated: true, completion: nil)
                                }
                            }
                        })
                    } else {
                        DispatchQueue.main.async {
                            // Future Feature wiht Sping Animation
                            //self.stopAnimatingCardXX()
//                            self.playerCardsBackSide()
                            
                            self.present(self.networkErrorAlert, animated: true, completion: nil)
                        }
                    }
                    guard successfullCard != nil else {return}
                    
                    // MARK: -  Outcome P1 Won
                    
                    if  successfullCard![0].rank > successfullCard![1].rank
                    {
                        //print("👠 Card 0: \(successfullCard![0].value) > Card 1: \(successfullCard![1].value)")
                        
                        ScoreController.shared.playerOneScore += 1
                        DispatchQueue.main.async {
                            self.userOneWonUpdateViewsLabel()
                            // Future Feature wiht Sping Animation
                            //self.stopAnimatingCardXX()
                            
                            self.playerOneScoreLabel.text = "\(ScoreController.shared.playerOneScore)"
                            
                            ScoreController.drawAgainP1(playerOneScore: ScoreController.shared.playerOneScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            
                            ScoreController.drawAgainP2(playerTwoScore: ScoreController.shared.playerOneScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            
                            DispatchQueue.main.async {
                                self.playerOneWonChecker()
                            }
                        }
                        print("\nPlayer #1 won\n")
                        
                        // MARK: - Outcome P2 Won
                        
                    } else if successfullCard![0].rank < successfullCard![1].rank {
                        //Test Print
                        //print("👗 Card 0:  \(successfullCard![0].value) < Card 1:  \(successfullCard![1].value)")
                        ScoreController.shared.playerTwoScore += 1
                        //👗 👗 👗 👗 👗 👗 👗 👗 👗 👗 👗 👗 👗
                        DispatchQueue.main.async {
                            self.userTwoWonUpdateViewsLabel()
                            
                            //Future Feature
                            //self.stopAnimatingCardXX()
                            
                            self.playerTwoScoreLabel.text = "\(ScoreController.shared.playerTwoScore)"
                            
                            ScoreController.drawAgainP1(playerOneScore: ScoreController.shared.playerTwoScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                            
                            ScoreController.drawAgainP2(playerTwoScore: ScoreController.shared.playerTwoScore, drawButton: self.drawButton, winnerLabel: self.winnerLabel)
                        }
                        
                        DispatchQueue.main.async {
                            self.playerTwoWonChecker()
                        }
                        
                        print("\nplayer #2 won\n")
                        print("\nPlayer Two raw score: \(ScoreController.shared.playerTwoScore)\n")
                        
                        // MARK: - Outcome Tie
                        
                    } else if successfullCard![0].rank == successfullCard![1].rank {
                        
                        //Test print
                        //print("🧶Card 0: \(successfullCard![0].value) == Card 1:  \(successfullCard![1].value)")
                        //ScoreController.shared.playerTwoScore += 0
                        //ScoreController.shared.playerTwoScore += 0
                        
                        // Future Feature wiht Sping Animation
                        //self.stopAnimatingCardXX()
                        DispatchQueue.main.async {
                            self.drawButton.setTitle("Tie, Draw Again", for: .normal)
                            self.UserOneAndTwoBlackLabelColorUI()
                            self.playerNameTwoLabel.text = "Tie"
                            self.playerNameOneLabel.text = "Tie"
                        }
                    }
                    
                })
            } else {
                
                // MARK: - if failed fetching two cards
                
                DispatchQueue.main.async {
                    // Future Feature wiht Sping Animation
                    //self.stopAnimatingCardXX()
//                    self.playerCardsBackSide()
                    self.present(self.networkErrorAlert, animated: true, completion: nil)
                    
                }
            }
        }
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
    
    func dummyCardDecksAppear() {
        
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
    
    // MARK: - Outcome control flow functions
    
    func playerOneWonChecker() {
        if ScoreController.shared.playerOneScore == 2 {
            
            ScoreController.shared.playerOneScore = 0
            ScoreController.shared.playerTwoScore = 0
            
            DispatchQueue.main.async {
                self.animateInBetView()
                self.userOneWonUpdateViewsLabel()
                
                self.hidePlayerScoreLabels()
                self.playerOneScoreLabel.text = "0"
                self.playerTwoScoreLabel.text = "0"
                self.drawButton.titleLabel?.text = "Play Again?"
                
                if self.playerOneName == "" {
                    self.winnerLabel.text =  "Player One Won!"
                    //self.drawButton.titleLabel?.text = "Play Again?"
                } else {
                    self.winnerLabel.text = "\(self.playerOneName ?? "Player One") Won!"
                    //self.drawButton.setTitle("Play Again?", for: .normal)
                }
                self.winnerLabel.isHidden = false
            }
        }
    }
    
    func playerTwoWonChecker() {
        if ScoreController.shared.playerTwoScore == 2 {
            
            ScoreController.shared.playerOneScore = 0
            ScoreController.shared.playerTwoScore = 0
            
            DispatchQueue.main.async {
                self.animateInBetView()
                self.userTwoWonUpdateViewsLabel()
                self.drawButton.setTitle("Play Again?", for: .normal)
                self.hidePlayerScoreLabels()
                self.playerTwoScoreLabel.text = "0"
                self.playerOneScoreLabel.text = "0"
                
                if self.playerTWoName == "" {
                    self.winnerLabel.text =  "Player Two Won!"
                } else {
                    self.winnerLabel.text = "\(self.playerTWoName ?? "Player Two") Won!"
                }
                self.winnerLabel.isHidden = false
            }
        }
    }
    
    func userOneWonUpdateViewsLabel() {
        UserOneWonLabelColorUI()
        switch playerTWoName {
        case "":
            self.playerNameTwoLabel.text = "Player Two Lost"
        default:
            self.playerNameTwoLabel.text = "\(playerTWoName ?? "Player Two") Lost"
        }
        switch playerOneName {
        case "":
            self.playerNameOneLabel.text = "Player One Won"
        default:
            self.playerNameOneLabel.text = "\(playerOneName ?? "Player One") Won"
        }
    }
    
    func userTwoWonUpdateViewsLabel(){
        UserTWOWonColorUI()
        switch playerOneName {
        case "":
            self.playerNameOneLabel.text = "Player One Lost"
        default:
            self.playerNameOneLabel.text = "\(playerOneName ?? "Player One") Lost"
        }
        
        switch playerTWoName {
        case "":
            self.playerNameTwoLabel.text = "Player Two Won"
        default:
            self.playerNameTwoLabel.text = "\(playerTWoName ?? "Player Two") Won"
        }
    }
    
    // MARK: - Font and Color for User Labels
    
    // Player One Won
    func UserOneWonLabelColorUI(){
        DispatchQueue.main.async {
            self.playerNameOneLabel.textColor = ColorController.green.value
            self.playerNameTwoLabel.textColor = ColorController.red.value
        }
    }
    
    // Player Two Won
    func UserTWOWonColorUI(){
        DispatchQueue.main.async {
            self.playerNameTwoLabel.textColor = ColorController.green.value
            self.playerNameOneLabel.textColor = ColorController.red.value
        }
    }
    
    func UserOneAndTwoBlackLabelColorUI() {
        DispatchQueue.main.async {
            self.playerNameOneLabel.textColor = .black
            self.playerNameTwoLabel.textColor = .black
        }
    }
    
    func playerCardsBackSide() {
        self.playerOneCardImage.image = backOfCardImage
        self.playerTwoCardImage.image = backOfCardImage
    }
}

//Future Feature
// MARK: -  Spin Animation

//extension GameBoardVC {
//    func startAnimatingCardXX() {
//        playerOneCardImage.spin()
//        playerTwoCardImage.spin()
//    }
//
//    func stopAnimatingCardXX() {
//        playerTwoCardImage.stopRotating()
//        playerOneCardImage.stopRotating()
//    }
//}

// NOTE: - Future Version
//func playerOneWonBet() {
//    self.hidePlayerNameLabels()
//    let unwrappedBetText = self.bet ?? "the odds were aginst you"
//    switch unwrappedBetText {
//    case "":
//        if self.playerOneName == "" {
//            self.betTextLabel.text = "Player Two lost, the odds were aginst you."
//        } else {
//            self.betTextLabel.text = "\(self.playerTWoName ?? "Player Two") \(unwrappedBetText)"
//        }
//    default:
//        break
//    }
//}
//
//
//func playerTwoWonBet() {
//    self.hidePlayerNameLabels()
//
//    let unwrappedBetText = self.bet ?? "the odds were aginst you"
//    switch unwrappedBetText {
//    case "":
//        if self.playerOneName == "" {
//            self.betTextLabel.text = "Player One lost, the odds were aginst you."
//        } else {
//            self.betTextLabel.text = "\(self.playerOneName ?? "Player Two") \(unwrappedBetText)"
//        }
//    default:
//        break
//    }
//}
//var prefersStatusBarHidden: Bool {
//    return false
//}
