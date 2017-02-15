//
//  TableViewController.swift
//  HideableItemsTabbarController
//
//  Created by Štěpán Votava on 14/02/2017.
//  Copyright © 2017 Inloop. All rights reserved.
//

import UIKit
import HideableItemsTabbarController

class TableViewController: UITableViewController, TableInsetsUpdatableController {
    override var tabBarHidden: Bool { return true }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 100
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let hideableItemsTabBarController = hideableItemsTabBarController else { return }
        hideableItemsTabBarController.tabBarIsHidden = !hideableItemsTabBarController.tabBarIsHidden
    }
}
