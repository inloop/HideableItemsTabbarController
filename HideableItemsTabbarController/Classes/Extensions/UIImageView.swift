//
//  UIImageView.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

internal extension UIImageView {
    func maskWithColor(color: UIColor) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}
