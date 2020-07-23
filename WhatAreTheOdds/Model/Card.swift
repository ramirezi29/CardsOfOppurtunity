//
//  Card.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

struct CardsDictionary: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let suit: String
    let image: String 
    let value: String
    
    var rank: Int {
        if let integerValue = Int(value) {
            return integerValue
        }
        switch value {
        case "ACE":
            return 1
        case "8":
            return 8
        case "9":
            return 9
        case "JACK":
            return 11
        case "QUEEN":
            return 12
        case "KING":
            return 13
        default:
            return 0
        }
    }
}

extension Card: Comparable {
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.rank < rhs.rank
    }
}
