//
//  HideableItemsTabBar.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 13/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit

final public class HideableItemsTabBar: UIView {
    weak var datasource: HideableItemsTabbarDataSource?
    weak var delegate: HideableItemsTabbarDelegate?

    // MARK: - Private vars
    var tabBarItems = [HideableItemsTabBarItem]()
    var selected: Int = 0
    var appearance: HideableItemsTabbarAppearance!

    lazy var topLine: UIView = {
        var lineFrame = self.bounds
        lineFrame.size.height = self.appearance.topLineHeight

        let line = UIView(frame: lineFrame)
        line.backgroundColor = self.appearance.topLineColor
        return line
    }()

    init(frame: CGRect, appearance: HideableItemsTabbarAppearance? = nil) {
        super.init(frame: frame)
        self.appearance = appearance ?? HideableItemsTabbarAppearance()

        backgroundColor = UIColor(white: 1, alpha: 0.99)
        addSubview(topLine)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func resize(frame: CGRect) {
        self.frame = frame
        topLine.frame.size.width = frame.width

        for (index, item) in tabBarItems.enumerated() {
            item.frame = self.frame(forItemAt: index)
        }
    }

    func setup() {

        guard let datasource = datasource else {
            fatalError("HideableItemsTabbar: dataSource has to be set")
        }

        tabBarItems.forEach {$0.removeFromSuperview()}
        tabBarItems = []

        for index in 0..<datasource.numberOfItems(in: self) {
            if let item = datasource.tabBarItem(in: self, at: index), item.isEnabled {
                let itemIndex = tabBarItems.count
                let tabBarItem = HideableItemsTabBarItem(item: item, with: index, appearance: self.appearance)
                configure(item: tabBarItem, at: itemIndex)

                addSubview(tabBarItem)
                tabBarItems.append(tabBarItem)
            }
        }
        resize(frame: frame)
    }

    private func configure(item: HideableItemsTabBarItem, at index: Int) {
        item.button.addTarget(self, action: #selector(barItemTapped(_:)), for: UIControlEvents.touchUpInside)
        item.button.tag = index
        item.isSelected = item.index == selected
    }

    private func frame(forItemAt index: Int) -> CGRect {
        let count = tabBarItems.count
        guard count > 0 else { return .zero }

        let isRtl = UIView.userInterfaceLayoutDirection(for: semanticContentAttribute) == .rightToLeft

        let tabBarContainerWidth = frame.width / CGFloat(count)
        let index = isRtl ? tabBarItems.count - index - 1 : index
        let tabBarContainerRect = CGRect(x: floor(tabBarContainerWidth * CGFloat(index)), y: 0, width: floor(tabBarContainerWidth), height: floor(self.frame.height))

        return tabBarContainerRect
    }

    func select(index: Int) {
        selected = index
        tabBarItems.forEach { $0.isSelected = $0.index == index }
    }

    @objc private func barItemTapped(_ sender: UIButton) {
        guard tabBarItems.count > sender.tag else { return }
        select(index: tabBarItems[sender.tag].index)
        
        delegate?.didSelectViewController(self, at: selected)
    }
}
