//
//  InsetUpdatable.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 14/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

public protocol InsetsUpdatable {
    var scrollView: ScrollViewType! { get }
    var hideableItemsTabBarController: HideableItemsTabbarController? { get }
    var navigationController: UINavigationController? { get }
    func updateInsets()
}

public protocol TableInsetsUpdatableController: InsetsUpdatable {
    var tableView: UITableView! { get }
}

public extension TableInsetsUpdatableController {
    var scrollView: ScrollViewType! {
        return tableView
    }
}

public protocol WebInsetsUpdatableController: InsetsUpdatable {
    var webView: UIWebView! { get }
}

public extension WebInsetsUpdatableController {
    var scrollView: ScrollViewType! {
        return webView.scrollView
    }
}

public protocol CollectionInsetsUpdatableController: InsetsUpdatable {
    var collectionView: UICollectionView! { get }
}

public extension CollectionInsetsUpdatableController {
    var scrollView: ScrollViewType! {
        return collectionView
    }
}

public extension InsetsUpdatable {
    func updateInsets() {
        guard let scrollView = scrollView as? UIScrollView else { return }
        
        if let tabBarController = hideableItemsTabBarController {
            var edges = scrollView.contentInset
            edges.bottom = tabBarController.bottomInset
            edges.top = navigationController?.navigationBar.frame.maxY ?? edges.top

            scrollView.contentInset = edges
            scrollView.scrollIndicatorInsets = edges
            scrollView.setNeedsLayout()
            scrollView.layoutIfNeeded()
        }
    }
}
