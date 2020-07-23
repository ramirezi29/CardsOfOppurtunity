//
//  PlayerController.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 7/22/20.
//  Copyright © 2020 ramcomw. All rights reserved.
//

import Foundation

class PlayerController {
    
    static let shared = PlayerController()
    
    var players: Player?
    
    func addPlayer(nameOne: String, nameTwo: String) {
        let gamePlayers =  Player(playerOneName: nameOne, playerTwoName: nameTwo)
        players = gamePlayers
        saveToPresistentStorage()
    }
    
    func updateNames(player: Player, nameOne: String, nameTWo: String) {
        player.playerOneName = nameOne
        player.playerTwoName = nameTWo
        saveToPresistentStorage()
    }
    
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        let fileName = Constants.playersFileKey
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    private func saveToPresistentStorage() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(players)
            try data.write(to: fileURL())
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func loadFromPersistentStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let data =  try Data(contentsOf: fileURL())
            let players = try jsonDecoder.decode(Player.self, from: data)
            self.players = players
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
