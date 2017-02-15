//
//  TabBarController.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 14/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit
import HideableItemsTabbarController

class TabBarController: HideableItemsTabbarController {
    override func viewDidLoad() {
        // Appearance has to be set before super.viewDidLoad()
        appearance = HideableItemsTabbarAppearance(tint: .lightGray, selectedTint: .red)

        super.viewDidLoad()
    }
}

extension TabBarController: HideableItemsTabbarControllerDelegate {
    func selected(viewController vc: UIViewController, at index: Int) {
        print("Selected viewController (\(vc)) at index \(index)")
    }
}
