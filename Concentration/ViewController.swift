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
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var gameScoreLabel: UILabel!
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    @IBAction private func pressNewGameButton(_ sender: UIButton) {
        flipCount = 0
        gameScoreLabel.text = "Score = 0"
        let randomThemeNumber = Int(arc4random_uniform(UInt32(allEmojies.count / 15))) + 1
        emojiChoices.removeAll()
        let upperBoundIndex = (randomThemeNumber * 15) - 1
        let lowerBoundIndex = (randomThemeNumber - 1) * 15
        emojiChoices.append(contentsOf: allEmojies[lowerBoundIndex...upperBoundIndex])
        emoji.removeAll()
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        for cardButton in cardButtons {
            cardButton.backgroundColor = UIColor.orange
            cardButton.setTitle("", for: .normal)
        }
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
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
        gameScoreLabel.text = "Score = \(game.gameScore)"
    }
    
    private var emojiChoices = ["🎃", "👻", "🦇", "😈", "🙀", "👹", "🤡", "🍭", "🍬", "😱", "💀", "☠️", "🧟‍♀️", "🧞‍♂️", "🕷"]

    private var allEmojies = ["🎃", "👻", "🦇", "😈", "🙀", "👹", "🤡", "🍭", "🍬", "😱", "💀", "☠️", "🧟‍♀️", "🧞‍♂️", "🕷",
                      "😃", "🤫", "🤥", "🤔", "🤗", "😁", "😂", "🤣", "😍", "😭", "😤", "😎", "🤪", "😚", "😒",
                      "⚽️" ,"🧗🏻‍♂️", "🏄🏻‍♂️", "🧘🏻‍♀️", "🤸🏻‍♂️", "🏀", "⚾️", "🏈", "🎾", "🏐", "🏉", "🎱", "🥋", "🥊", "⛹🏻‍♂️",
                      "🐭" ,"🐒", "🐧", "🐥" ,"🐺", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷",
                      "🍏", "🥦", "🥕", "🥒", "🍅", "🍐", "🍊", "🍋", "🍌", "🍉", "🍇", "🍓", "🍈", "🍒", "🥑",
                      "🥐", "🍕", "🥪", "🍰", "🎂", "🍗", "🍖", "🌭", "🍟", "🍔", "🌮", "🥙", "🥪", "🥟", "🥗",
                      "🚗", "🚕", "🚙", "🚑", "🚓" ,"🏎", "🚚", "🛵", "🏍", "🚅", "✈️", "🚢", "🚁", "🛶" , "⛵️"]
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        
        return emoji[card.identifier] ?? "?"
    }

}
