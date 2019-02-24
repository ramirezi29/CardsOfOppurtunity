//
//  Score.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import Foundation

class Score {
    
    var winningGameScore: Int? = 5
    var user1ActualScore: Int = 0
    var user2ActualScore: Int = 0
    
    init(user1ActualScore: Int, user2ActualScore: Int) {
        self.user1ActualScore = user1ActualScore
        self.user2ActualScore = user2ActualScore
    }
}

extension Score : Equatable {
    static func == (lhs: Score, rhs: Score) -> Bool {
        if lhs.user1ActualScore != rhs.user1ActualScore {return false}
        if lhs.user2ActualScore != rhs.user2ActualScore {return false}
        if lhs.winningGameScore != rhs.winningGameScore {return false}
        return true
    }
}
