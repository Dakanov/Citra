//
//  CodeVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 28.09.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import AKMaskField 

class CodeVC: UIViewController {

    // MARK: - Variables
    var  phone = ""
    var fromLogin = false
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendButton.applyGradient()
        
    }
    
    // MARK: - Outlets
    
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var textField: AKMaskField!
    
    // MARK: - Actions
    
    @IBAction func changeNumberPressed(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
     checkCode()
    }
    
    // MARK: - Function
    
    func checkCode(){
        var login = "login"
        if fromLogin {
            login = "login"
        } else {
         login = "signup"
        }
        sendLogin(login: login)
    }
    
    func sendLogin(login:String){
        let parameters = ["phone": phone,
        "code": textField.text!] as [String: AnyObject]
        loginReq(login: login ,parameters: parameters) { (info) in
            if let token = info.token {
                UserDefaults.standard.set(token, forKey: "token")
                self.performSegue(withIdentifier: "checked", sender: self)
            }
            if let err = info.error {
                print(err)
                self.showAlert(title: "Внимание", message: err)
            }
            if let success = info.success {
                print(success)
            }
        }
    }
   
   

}


