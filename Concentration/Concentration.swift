//
//  Concentration.swift
//  Concentration
//
//  Created by Amirhossein on 9/24/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var gameScore = 0
    
    var previouslySeenCardsIdentifiers = [Int]()
    
    func chooseCard (at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//                Check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
//                Either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
 
    init(numberOfPaireOfCards: Int){
        for _ in 0..<numberOfPaireOfCards {
            let card = Card()
            cards += [card, card]
        }
        //        TODO: Shuffle the cards
        var randomCards = [Card]()
        while cards.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            randomCards.append(cards.remove(at: randomIndex))
        }
        cards = randomCards
    }
    
}
