//
//  HideableItemsTabbarProtocols.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

internal protocol HideableItemsTabbarDataSource: class {
    func numberOfItems(in tabBarView: HideableItemsTabBar) -> Int
    func tabBarItem(in tabBarView: HideableItemsTabBar, at index: Int) -> UITabBarItem?
}

internal protocol HideableItemsTabbarDelegate: class {
    func didSelectViewController(_ tabBarView: HideableItemsTabBar, at index: Int)
}
