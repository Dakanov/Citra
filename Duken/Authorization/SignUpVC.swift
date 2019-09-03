//
//  SignUpVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 22.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import AKMaskField

class SignUpVC: UIViewController, UITextFieldDelegate {

    // MARK: - Variable
    var user : RegisterData?
    var phone = ""
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        size()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    // MARK: - Outlets
    @IBOutlet var signUpOutlet: UIButton!
    @IBOutlet var nameText: UITextField!
    @IBOutlet var emailText: AKMaskField!
    @IBOutlet var passwordText: UITextField!
    @IBOutlet var checkPasswordText: UITextField!
    
    
    // MARK: - Actions
    @IBAction func signUpPressed(_ sender: UIButton) {
        textCheck()
    }
    
    // MARK: - Functions
    func textCheck(){
        if !(nameText.text?.isEmpty)! {
            if !(emailText.text?.isEmpty)! {
                if (passwordText.text?.count)! >= 6 {
                    if passwordText.text == checkPasswordText.text {
                        let unfiltered = emailText.text!
                        let removal: [Character] = ["(", " ", ")","+", "-"]
                        let unfilteredCharacters = unfiltered
                        let filteredCharacters = unfilteredCharacters.filter { !removal.contains($0) }
                        let filtered = String(filteredCharacters)
                        self.phone = filtered
                        signUp()
                    } else {
                        print("password isnt same")
                        showAlert(title: "Внимание", message: "Пароли не совподают")
                    }
                } else {
                    print("password symbol less than 6")
                    showAlert(title: "Внимание", message: "Пароль должен содержать больше 6 символов")
                }
            } else {
                print("phone is empty")
                showAlert(title: "Внимание", message: "Введите правильный номер")
            }
        } else {
            showAlert(title: "Внимание", message: "Введите имя")
            print("name is empty")
        }
    }
    func signUp() {
    let parameters = ["name": nameText.text!,
                      "phone": phone,
        "password": passwordText.text!] as [String: AnyObject]
        
        signUpReq(parameters: parameters) { (info) in
            self.user = info
            if let token = self.user?.token {
                UserDefaults.standard.set(token, forKey: "token")
                print("Пользователь успешно зарегистрирован!")
                self.performSegue(withIdentifier: "Registred", sender: self)
            } else {
                if let success = info.success {
                    if success {
                        self.performSegue(withIdentifier: "toCodeRegister", sender: self)
                    }
                }
                
            }
        }
        
        
            
    }
    func size(){
        signUpOutlet.layer.borderWidth = 1
        signUpOutlet.layer.cornerRadius = 10
        signUpOutlet.layer.borderColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCodeRegister"{
            let sub: CodeVC = segue.destination as! CodeVC
            sub.fromLogin = false
            sub.phone = self.phone
        }
    }
    
}
