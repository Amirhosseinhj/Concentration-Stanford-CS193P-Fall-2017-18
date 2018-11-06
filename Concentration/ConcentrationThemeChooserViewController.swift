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

    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentraitionViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcentraitionViewController : ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }


}
