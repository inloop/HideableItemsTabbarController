//
//  HideableItemsTabbarController.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

open class HideableItemsTabbarController: UITabBarController, HideableItemsTabbarDataSource, HideableItemsTabbarDelegate {
    public var tabbarDelegate: HideableItemsTabbarControllerDelegate?
    public var appearance: HideableItemsTabbarAppearance?
    
    lazy var customTabBar: HideableItemsTabBar = {
        let customTabBar = HideableItemsTabBar(frame: self.tabBar.frame, appearance: self.appearance)
        customTabBar.datasource = self
        customTabBar.delegate = self
        customTabBar.setup()

        self.view.addSubview(customTabBar)
        self.tabBar.isHidden = true
        return customTabBar
    }()

    public var tabBarIsHidden: Bool  = false {
        didSet {
            if oldValue != tabBarIsHidden,
                let vc = (selectedViewController as? UINavigationController)?.topViewController ?? selectedViewController,
                let updatable = vc as? InsetsUpdatable {

                vc.automaticallyAdjustsScrollViewInsets = false
                updatable.updateInsets()
            }
            setTabBarVisible(!tabBarIsHidden, animated: true) { [weak self] (_) in
                self?.customTabBar.alpha = self?.tabBarIsHidden == false ? 1 : 0
            }
        }
    }

    open override var selectedIndex: Int {
        didSet {
            guard oldValue != selectedIndex else { return }
            customTabBar.select(index: selectedIndex)
        }
    }

    var bottomInset: CGFloat {
        return tabBarIsHidden ? 0 : tabBar.frame.height
    }

    // MARK: - View Controller overrides
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updatePosition()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        customTabBar.setup()
    }

    private func updatePosition() {
        let statusBarHeight = view.frame.minY > 0 ? UIApplication.shared.statusBarFrame.size.height - view.frame.minY : 0
        let originY = isTabBarIsVisible ? UIScreen.main.bounds.height - statusBarHeight - tabBar.frame.height : UIScreen.main.bounds.height - statusBarHeight
        tabBar.frame = CGRect(x: 0, y: originY, width: UIScreen.main.bounds.width, height: tabBar.frame.height)
        customTabBar.resize(frame: tabBar.frame)
        view.bringSubview(toFront: customTabBar)
    }

    // MARK: - Public functions
    public func setTabBarVisible(_ visible: Bool, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        guard isTabBarIsVisible != visible else { return }

        let frame = tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        customTabBar.alpha = 1
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            self.customTabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)

            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }, completion: completion)
    }

    public func setItem(at index: Int, hidden: Bool) {
        if let items = tabBar.items, index < items.count, items[index].isEnabled != !hidden {
            items[index].isEnabled = !hidden
            customTabBar.setup()
        }
    }

    public func isHidden(at index: Int) -> Bool {
        guard let items = tabBar.items, index < items.count else { return true }
        return !items[index].isEnabled
    }

    // MARK: - Private functions
    private var isTabBarIsVisible: Bool {
        get {
            let statusBarHeight = view.frame.minY > 0 ? UIApplication.shared.statusBarFrame.size.height - view.frame.minY : 0
            let originY = UIScreen.main.bounds.height - statusBarHeight
            return self.tabBar.frame.origin.y < originY
        }
    }

    // MARK: - HideableItemsTabbarDataSource
    public func numberOfItems(in tabBarView: HideableItemsTabBar) -> Int {
        return tabBar.items?.count ?? 0
    }

    public func tabBarItem(in tabBarView: HideableItemsTabBar, at index: Int) -> UITabBarItem? {
        guard let items = tabBar.items, items.count > index else { return nil }
        return items[index]
    }

    // MARK: - HideableItemsTabbarDelegate
    public func didSelectViewController(_ tabBarView: HideableItemsTabBar, at index: Int) {
        guard let items = tabBar.items,
            index < items.count,
            index < childViewControllers.count else { return }

        selectedIndex = index
        tabbarDelegate?.selected(viewController: childViewControllers[selectedIndex], at: index)
    }
}
