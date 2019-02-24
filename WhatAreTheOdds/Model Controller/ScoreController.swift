//
//  ScoreController.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class ScoreController {
    
    // Singleton
    static let shared = ScoreController()
    
    //Sourece of truth
    var scores = [Score]()
    
    var playerOneScore = 0
    var playerTwoScore = 0
    
    // Draw
    func drawChecker(with user1GameScore: Int, user2GameScore: Int) -> Bool  {
        if user1GameScore == user2GameScore {
            let _ = Score(user1ActualScore: user1GameScore, user2ActualScore: user2GameScore)
        }
        return true
    }
    
    static func drawAgainP1(playerOneScore: Int, drawButton: UIButton, winnerLabel: UILabel) {
        switch playerOneScore {
        case 0:
            winnerLabel.isHidden = true
            drawButton.setTitle("Draw Again", for: .normal)
        case 1:
            drawButton.setTitle("Draw Again", for: .normal)
        case 2:
            drawButton.setTitle("Draw Again", for: .normal)
        default:
            break
        }
    }
    
    static func drawAgainP2(playerTwoScore: Int, drawButton: UIButton, winnerLabel: UILabel) {
        switch playerTwoScore {
        case 0:
            winnerLabel.isHidden = true 
            drawButton.setTitle("Draw Again", for: .normal)
        case 1:
            drawButton.setTitle("Draw Again", for: .normal)
        case 2:
            drawButton.setTitle("Draw Again", for: .normal)
        default:
            break
        }
    }
    
}
