//
//  HideableItemsTabbarAppearance.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

public struct HideableItemsTabbarAppearance {
    var selectedTintColor: UIColor
    var tintColor: UIColor
    var topLineColor: UIColor
    var topLineHeight: CGFloat
    var itemMargin: CGFloat
    var font: UIFont

    public init(tint color: UIColor = .darkGray,
                selectedTint selectedColor: UIColor = UIApplication.shared.keyWindow?.tintColor ?? .blue,
                dividerColor: UIColor = .lightGray,
                dividerHeight: CGFloat = 0.5,
                font: UIFont = UIFont.systemFont(ofSize: 11.0),
                itemMargin: CGFloat = 3.0) {
        tintColor = color
        selectedTintColor = selectedColor
        topLineColor = dividerColor
        topLineHeight = dividerHeight
        self.font = font
        self.itemMargin = itemMargin
    }
}
