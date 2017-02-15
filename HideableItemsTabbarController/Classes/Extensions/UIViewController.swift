//
//  UIViewController.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 14/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

public protocol HideableTabbarControllable {
    var tabBarHidden: Bool { get }
}

private let swizzling: (UIViewController.Type) -> () = { viewController in

    var originalMethod = class_getInstanceMethod(viewController, #selector(viewController.viewWillAppear(_:)))
    var swizzledMethod = class_getInstanceMethod(viewController, #selector(viewController.htc_viewWillAppear(_:)))

    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension UIViewController: HideableTabbarControllable {
    open var tabBarHidden: Bool { return false }

    public var hideableItemsTabBarController: HideableItemsTabbarController? {
        return tabBarController as? HideableItemsTabbarController
    }

    open override class func initialize() {
        guard self === UIViewController.self else { return }
        swizzling(self)
    }

    func htc_viewWillAppear(_ animated: Bool) {
        self.htc_viewWillAppear(animated)

        hideableItemsTabBarController?.tabBarIsHidden = tabBarHidden
    }
}
