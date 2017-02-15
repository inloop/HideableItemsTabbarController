//
//  HideableItemsTabbarControllerProtocols.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

public protocol HideableItemsTabbarControllerDelegate: class {
    func selected(viewController vc: UIViewController, at index: Int)
}
