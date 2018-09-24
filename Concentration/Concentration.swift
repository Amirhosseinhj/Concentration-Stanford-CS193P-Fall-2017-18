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
    
    func chooseCard (at index: Int) {
        
    }
 
    init(numberOfPaireOfCards: Int){
        for _ in 0..<numberOfPaireOfCards {
            let card = Card()
            cards += [card, card]
        }
        //        TODO: Shuffle the cards
    }
    
}
