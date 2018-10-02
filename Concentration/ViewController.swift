//
//  ViewController.swift
//  Concentration
//
//  Created by Amirhossein on 9/24/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
// Big green arrow from controller to model!
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var gameScoreLabel: UILabel!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction private func pressNewGameButton(_ sender: UIButton) {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        updateViewFromModel()
//        Setting up new theme
        let randomThemeNumber = Int(arc4random_uniform(UInt32(allEmojies.count / 15))) + 1
        emojiChoices.removeAll()
        let lowerBoundIndex = allEmojies.index(allEmojies.startIndex, offsetBy: (randomThemeNumber - 1) * 15)
        let upperBoundIndex = allEmojies.index(allEmojies.startIndex, offsetBy: (randomThemeNumber * 15) - 1)
        emojiChoices = String(allEmojies[lowerBoundIndex...upperBoundIndex])
        
        emoji.removeAll()
        for cardButton in cardButtons {
            cardButton.isEnabled = true
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 5.0,
            .strokeColor : UIColor.orange
        ]
        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                if card.isMatched {
                    button.isEnabled = false
                     button.backgroundColor = UIColor.clear
                } else {
                    button.backgroundColor = UIColor.orange
                }
            }
        }
        gameScoreLabel.text = "Score = \(game.gameScore)"
        updateFlipCountLabel()
    }
    
    private var emojiChoices = "🎃👻🦇😈🙀👹🤡🍭🍬😱💀☠️🧟‍♀️🧞‍♂️🕷"

    private var allEmojies = "🎃👻🦇😈🙀👹🤡🍭🍬😱💀☠️🧟‍♀️🧞‍♂️🕷😃🤫🤥🤔🤗😁😂🤣😍😭😤😎🤪😚😒⚽️🧗🏻‍♂️🏄🏻‍♂️🧘🏻‍♀️🤸🏻‍♂️🏀⚾️🏈🎾🏐🏉🎱🥋🥊⛹🏻‍♂️🐭🐒🐧🐥🐺🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷🍏🥦🥕🥒🍅🍐🍊🍋🍌🍉🍇🍓🍈🍒🥑🥐🍕🥪🍰🎂🍗🍖🌭🍟🍔🌮🥙🥪🥟🥗🚗🚕🚙🚑🚓🏎🚚🛵🏍🚅✈️🚢🚁🛶⛵️"
    
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4Random)
                emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        return emoji[card] ?? "?"
    }

}

extension Int {
    var arc4Random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return  -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
