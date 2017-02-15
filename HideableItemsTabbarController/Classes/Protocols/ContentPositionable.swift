//
//  ContentPositionable.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 14/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

public protocol ContentPositionable: class {
    var contentOffset: CGPoint { get set }
    var contentInset: UIEdgeInsets { get set }
}

public protocol ScrollViewType: ContentPositionable { }

extension UIScrollView: ScrollViewType { }
