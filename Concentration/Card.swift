//
//  Card.swift
//  Concentration
//
//  Created by Amirhossein on 9/24/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    init(identifier: Int) {
        self.identifier = identifier
    }
}
