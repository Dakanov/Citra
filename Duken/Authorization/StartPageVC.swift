//
//  StartPageVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 22.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit

class StartPageVC: UIViewController {
    // MARK: - Variable
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        skipOutlet.applyGradient()
    }
    override func viewWillAppear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = true
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    // MARK: - Outlets
    @IBOutlet var skipOutlet: UIButton!
    // MARK: - Actions
    @IBAction func skipPressed(_ sender: UIButton) {
    }
    // MARK: - Functions
}
