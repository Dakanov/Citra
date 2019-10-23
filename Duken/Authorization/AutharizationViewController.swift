//
//  AutharizationViewController.swift
//  Duken
//
//  Created by Dakanov Sultan on 22.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit

class AutharizationViewController: UIViewController {

    // MARK: - Variable
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        demoButton.underline()
        size()
    }
    
    // MARK: - Outlets
    
    @IBOutlet var looginOutlet: UIButton!
    @IBOutlet var registrationOutlet: UIButton!
    @IBOutlet weak var demoButton: UIButton!
    
    
    // MARK: - Actions
    @IBAction func loginPressed(_ sender: UIButton) {
    performSegue(withIdentifier: "ToLogin", sender: self)
    }
    @IBAction func registrationPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ToReg", sender: self)
    }
    
    // MARK: - Functions
    func size(){
        looginOutlet.layer.borderWidth = 1
        looginOutlet.layer.cornerRadius = 10
        looginOutlet.layer.borderColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        registrationOutlet.applyGradient()
    }
    
}
