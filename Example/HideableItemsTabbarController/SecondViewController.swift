//
//  SecondViewController.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    @IBAction func showHideTabbar(_ sender: Any) {
        guard let tabBarController = hideableItemsTabBarController,
            let sender = sender as? UIButton else { return }

        if tabBarController.tabBarIsHidden {
            sender.setTitle("Hide tabbar", for: .normal)
        } else {
            sender.setTitle("Show tabbar", for: .normal)
        }
        tabBarController.tabBarIsHidden = !tabBarController.tabBarIsHidden
    }
}

