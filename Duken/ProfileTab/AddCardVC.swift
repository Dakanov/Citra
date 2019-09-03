//
//  AddCardVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 14.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import AKMaskField

class AddCardVC: UIViewController, UITextFieldDelegate, UIWebViewDelegate {
    
    // MARK: - Variables
    var cryptoCrypt = String()
    var apiPublicID = "pk_2ebebb8bfb32481178d03261d466f"
    var card : OplataObj?
    var htmlCode = String()
    var tranzId = String()
    let w = UIWebView()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        w.delegate = self
        month.addTarget(self, action: #selector(checkMonth), for: .editingDidEnd)
        year.addTarget(self, action: #selector(checkYear), for: .editingDidEnd)
}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // MARK: - Outlets
    
    @IBOutlet var cardNumber: AKMaskField!
    @IBOutlet var name: UITextField!
    @IBOutlet var month: AKMaskField!
    @IBOutlet var year: AKMaskField!
    @IBOutlet var cvc: AKMaskField!
    @IBOutlet var saveOutlet: UIButton!
    @IBOutlet var cardView: UIView!
    
    // MARK: - Actions
    @IBAction func savePressed(_ sender: UIButton) {
        checkText()
    }
    
    func saveCard() {
        self.view.startLoading()
        let date = year.text! + month.text!
        cryptoCrypt = CPService().makeCardCryptogramPacket(cardNumber.text!, andExpDate: date, andCVV: cvc.text, andStorePublicID: apiPublicID)
        let parameters = ["CardCryptogramPacket": cryptoCrypt,
                          "Name": name.text!,
                          "IpAddress": "1"] as [String: AnyObject]
        sendCard(parameters: parameters) {
            succ in
            if let success = succ.success {
                if success == true {
                    self.doneAlert()
                }
                else {
                    self.errorAlert()
                }
            }
            if let htmlcode = succ.htmlString {
                self.htmlCode = htmlcode
                if let tranzId = succ.transactionId {
                    self.tranzId = String(tranzId)
                }
                self.loadHtmlCode()
                self.w.frame = CGRect(x: 0, y:64, width: width, height: height - 64)
            }
        }
    }
    
    // MARK: - Functions
    func loadHtmlCode() {
        self.view.addSubview(w)
        w.loadHTMLString(htmlCode, baseURL: nil)
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.checktranz()
        }
    }
    
    @objc func checkMonth(textField: UITextField) {
        let maxMonth = Int(textField.text!)
        guard let check = maxMonth,
            check <= 12 && check > 0 else {
                alertView(title: "Вы ввели не правильный месяц", message: "Попробуйте снова")
                month.text?.removeAll()
                return
        }
        month.endEditing(true)
        month.resignFirstResponder()
        year.becomeFirstResponder()
    }
    
    @objc func checkYear(textField: UITextField) {
        let maxYear = Int(textField.text!)
        guard let check = maxYear,
            check >= 18 else {
                alertView(title: "Вы ввели не правильный год", message: "Попробуйте снова")
                year.text?.removeAll()
                return
        }
    }
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    func checktranz(){
        checktransaction(transactionId: tranzId) { (succes) in
            if succes.transaction?.payed == true {
                self.w.removeFromSuperview()
                self.view.stopLoading()
                self.doneAlert()
            } else {
                if succes.transaction?.checked == true {
                    self.w.removeFromSuperview()
                    self.view.stopLoading()
                    self.errorAlert()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.view.addSubview(self.w)
                    }
                }
            }
        }
    }
    
    func checkText() {
        if  cardNumber.text?.last != "*" {
            if name.text != "" {
                if month.text?.last != "*" && year.text?.last != "*"  {
                    if cvc.text?.last != "*" {
                        self.saveCard()
                    } else {
                        alertView(title: "Введите пожалуйста код CVC", message: "")
                    }
                } else {
                    alertView(title: "Введите пожалуйста срок истечение вашей карты", message: "")
                }
            } else {
                alertView(title: "Введите пожалуйста имя владельца карты", message: "")
            }
        } else {
            alertView(title: "Введите пожалуйста номер вашей карты", message: "")
        }
    }
    
    func setView(){
        cardView.layer.borderWidth = 0.4
        cardView.layer.borderColor = UIColor.lightGray.cgColor
        cardView.shadow()
        saveOutlet.layer.cornerRadius = 10
        saveOutlet.layer.borderWidth = 0.4
        saveOutlet.shadow()
        saveOutlet.applyGradient()
    }
    
    func doneAlert() {
        let alert = UIAlertController(title: "УРА!", message: "Карта добавлена успешно! ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Готово", style: .cancel, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }
        ))
        self.present(alert, animated: true)
    }
    
    func errorAlert(){
        let alert = UIAlertController(title: "ОШИБКА!", message: "Карта не прикреплена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: { action in
            self.navigationController?.popViewController(animated: true)
        }
        ))
        self.present(alert, animated: true)
    }
}
