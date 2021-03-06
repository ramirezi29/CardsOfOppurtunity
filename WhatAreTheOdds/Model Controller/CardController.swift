//
//  CardController.swift
//  WhatAreTheOdds
//
//  Created by Ivan Ramirez on 2/10/19.
//  Copyright © 2019 ramcomw. All rights reserved.
//

import UIKit

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new")
    
    private init() {}
    
    typealias FetchCardsCompletion = ([Card]?, NetworkingError?) -> Void
    
    typealias FetchImageCompletion = ((UIImage?), NetworkingError?) -> Void
    
    // MARK: - Fetch Cards
    static func fetchCards(amount: Int = 2, completion: @escaping FetchCardsCompletion) {
        
        guard let url = baseURL else { completion (nil, NetworkingError.badBaseURL("Bad base URL"))
            return }
        
        let builtURL = url.appendingPathComponent("draw").appendingPathComponent("/")
        
        var components = URLComponents(url: builtURL, resolvingAgainstBaseURL: true)
        let drawTwo = URLQueryItem(name: "count", value: "\(amount)")
        components?.queryItems = [drawTwo]
        
        guard let queryURL = components?.url else { return }
        var request = URLRequest(url: queryURL)
        request.httpMethod = NetworkController.HTTPMethod.get.rawValue
 
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with fetching the cards in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
                completion(nil, .forwardedError(error)); return
            }
            guard let data = data else { completion(nil, .invalidData("Invalid Data")); return }
            do {
                let topLevelDictionary = try JSONDecoder().decode(CardsDictionary.self, from: data)
                let cardsFromWeb = topLevelDictionary.cards
                completion(cardsFromWeb, nil)
                
            } catch let error {
                print("Error decoding object: \(error) \(error.localizedDescription)")
                completion(nil, .forwardedError(error)); return
            }
        }.resume()
    }
}

extension CardController {
    
    static func fetchImagesFor(card: Card, completion: @escaping FetchImageCompletion) {
        guard let url = URL(string: card.image) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("\n\n🚀 There was an error with fetching the image in: \(#file) \n\n \(#function); \n\n\(error); \n\n\(error.localizedDescription) 🚀\n\n")
            }
            guard let data = data else { completion(nil, .invalidData("Invalid Data")); return }
            let imageFromWeb = UIImage(data: data)
            completion(imageFromWeb, nil)
        }.resume()
    }
}


