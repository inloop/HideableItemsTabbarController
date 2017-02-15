//
//  HideableItemsTabBarItem.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

final public class HideableItemsTabBarItem: UIView {

    internal let button = UIButton()
    internal let iconView = UIImageView()
    internal let label = UILabel()
    internal var index: Int!

    //MARK: - private variables
    private var image: UIImage?
    private var selectedImage: UIImage?

    private var appearance: HideableItemsTabbarAppearance!

    public var isSelected = false {
        didSet {
            iconView.image = isSelected ? selectedImage : image
            let color = isSelected ? appearance.selectedTintColor : appearance.tintColor

            iconView.maskWithColor(color: color)
            label.textColor = color
        }
    }

    override public var frame: CGRect {
        didSet { setFrames() }
    }

    init(item: UITabBarItem, with index: Int, appearance: HideableItemsTabbarAppearance) {
        self.appearance = appearance
        super.init(frame : .zero)

        self.index = index

        image = item.image
        selectedImage = item.selectedImage

        setup(item: item)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setFrames()

        addSubview(label)
        addSubview(iconView)
        addSubview(button)
    }

    private func setFrames() {
        label.frame = CGRect(x: CGFloat(0),
                             y: self.frame.height - appearance.font.pointSize - appearance.itemMargin,
                             width: frame.width,
                             height: appearance.font.pointSize)

        if let size = image?.size {
            iconView.frame = CGRect(x: floor(frame.width/2 - size.width/2),
                                    y: floor((frame.height - label.frame.height - appearance.itemMargin)/2 - size.height/2),
                                    width: size.width,
                                    height: size.height)
        }

        button.frame = bounds
    }

    private func setup(item: UITabBarItem) {
        setup()

        label.text = item.title
        label.font = appearance.font
        label.textAlignment = .center
        
        iconView.contentMode = .center
    }
}
