//
//  FirstViewController.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBAction func showHideTab(_ sender: Any) {
        guard let tabBarController = hideableItemsTabBarController,
            let sender = sender as? UIButton else { return }

        if tabBarController.isHidden(at: 1) {
            sender.setTitle("Hide second tab", for: .normal)
        } else {
            sender.setTitle("Show second tab", for: .normal)
        }
        tabBarController.setItem(at: 1, hidden: !tabBarController.isHidden(at: 1))
    }
}

