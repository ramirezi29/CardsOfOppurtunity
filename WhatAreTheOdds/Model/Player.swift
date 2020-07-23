//
//  Player.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 7/22/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import Foundation

class Player: Codable {
    var playerOneName: String
    var playerTwoName: String
    
    init(playerOneName: String, playerTwoName: String) {
        self.playerOneName = playerOneName
        self.playerTwoName = playerTwoName
    }
}
