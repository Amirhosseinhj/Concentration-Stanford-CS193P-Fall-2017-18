//
//  Concentration.swift
//  Concentration
//
//  Created by Amirhossein on 9/24/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
//                Damn this line of code is dope!
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    var gameScore = 0
    
    var previouslySeenCards = [Card]()
    
    var flipCount = 0
    
    mutating func chooseCard (at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
//                Check if cards match
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    gameScore += 2
                } else {
//                    it is a miss match
                    if previouslySeenCards.contains(cards[matchIndex]){
                        gameScore -= 1
                        if cards[index].alreadySeen{
                            gameScore -= 1
                        } else {
                            cards[index].alreadySeen = true
                            if !previouslySeenCards.contains(cards[index]){
                                previouslySeenCards.append(cards[index])
                            }
                        }
                    } else {
                        previouslySeenCards.append(cards[matchIndex])
                        cards[matchIndex].alreadySeen = true
                        cards[index].alreadySeen = true
                        if !previouslySeenCards.contains(cards[index]){
                            previouslySeenCards.append(cards[index])
                        }
                    }
                }
                cards[index].isFaceUp = true
            } else {
//                Either no cards or 2 cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
 
    init(numberOfPairsOfCards: Int){
        assert(numberOfPairsOfCards > 0, "Concentration.init( \(numberOfPairsOfCards)): you must have at least one pair of cards")
        for _ in 0..<numberOfPairsOfCards {
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
