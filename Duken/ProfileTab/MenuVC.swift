//
//  MenuVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 19.09.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit

class MenuVC: UIViewController {
    // MARK: - Variables
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        oneView.shadow()
        twoView.shadow()
    }
    // MARK: - Outlets
    @IBOutlet var oneView: UIView!
    @IBOutlet var twoView: UIView!
    // MARK: - Actions
    // MARK: - Functions
}
