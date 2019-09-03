//
//  loginVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 22.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import AKMaskField

class loginVC: UIViewController, UITextFieldDelegate {
    // MARK: - Variable
    var user : RegisterData?
    var phone = ""
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        emailText.delegate = AKMaskField
        passwordText.delegate = self
        size()
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    // MARK: - Outlets
    
    @IBOutlet var loginOutlet: UIButton!
    @IBOutlet var emailText: AKMaskField!
    @IBOutlet var passwordText: UITextField!
    
    // MARK: - Actions
    
    @IBAction func loginPressed(_ sender: UIButton) {
    checkText()
    }
    
    
    // MARK: - Functions
    func checkText() {
        if emailText.text != "" {
            self.login()
         
        } else {
            print("email is empty")
        }
    }
    func login() {
        let unfiltered = emailText.text!
        let removal: [Character] = ["(", " ", ")","+", "-"]
        let unfilteredCharacters = unfiltered
        let filteredCharacters = unfilteredCharacters.filter { !removal.contains($0) }
        let filtered = String(filteredCharacters)
        self.phone = filtered
        let parameters = ["phone": phone] as [String: AnyObject]
        
        checkPhone(parameters: parameters) { (info) in
            self.user = info
            if let token = self.user?.token {
                UserDefaults.standard.set(token, forKey: "token")
                print("Пользователь успешно зарегистрирован!")
                self.performSegue(withIdentifier: "Entered", sender: self)
            } else {
                if let success = self.user?.success {
                    if success {
                        self.performSegue(withIdentifier: "toCodeLogin", sender: self)
                    }
                }
                if let err = info.error {
                    print(err)
                }
            }
        }
    }
    
    func size(){
        loginOutlet.layer.borderWidth = 1
        loginOutlet.layer.cornerRadius = 10
        loginOutlet.layer.borderColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCodeLogin"{
            let sub: CodeVC = segue.destination as! CodeVC
            sub.fromLogin = true
            sub.phone = self.phone
        }
    }
}
