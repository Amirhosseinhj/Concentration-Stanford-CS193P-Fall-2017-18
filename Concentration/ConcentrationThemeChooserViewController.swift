//
//  ConcentrationThemeChooserViewController.swift
//  Concentration
//
//  Created by Amirhossein on 11/6/18.
//  Copyright © 2018 Amirhossein Haji Jafari. All rights reserved.
//

import UIKit

class ConcentrationThemeChooserViewController: UIViewController {

    private let themes = ["Halloween":"🎃👻🦇😈🙀👹🤡🍭🍬😱💀☠️🧟‍♀️🧞‍♂️🕷",
                          "Faces":"😃🤫🤥🤔🤗😁😂🤣😍😭😤😎🤪😚😒",
                          "Sports":"⚽️🧗🏻‍♂️🏄🏻‍♂️🧘🏻‍♀️🤸🏻‍♂️🏀⚾️🏈🎾🏐🏉🎱🥋🥊⛹🏻‍♂️",
                          "Animals":"🐭🐒🐧🐥🐺🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷",
                          "Fruites":"🍏🥦🥕🥒🍅🍐🍊🍋🍌🍉🍇🍓🍈🍒🥑",
                          "Food":"🥐🍕🥪🍰🎂🍗🍖🌭🍟🍔🌮🥙🥪🥟🥗",
                          "Vehicles":"🚗🚕🚙🚑🚓🏎🚚🛵🏍🚅✈️🚢🚁🛶⛵️"
    ]
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                }
            }
        }
    }


}
