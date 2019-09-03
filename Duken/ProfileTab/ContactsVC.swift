//
//  ContactsVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 19.09.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import MessageUI

class ContactsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, MFMailComposeViewControllerDelegate {
    
    // MARK: - Variables
    
    var contacts : Contacts?
    var contactsList = [""]
    var email = [""]
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getContactsReq()
        tableView.delegate = self
        tableView.dataSource = self
        boxView.shadow()
        tableView.tableFooterView = UIView()
    }
    // MARK: - Outlets
    
    @IBOutlet var boxView: UIView!
    @IBOutlet var tableView: UITableView!
    // MARK: - Actions
    
    
    // MARK: - Functions
    func getContactsReq(){
        getContacts { (contacts) in
            self.contacts = contacts
            if let count = contacts.contacts?.phones?.count, count > 0 {
                self.contactsList = (self.contacts?.contacts?.phones)!
            }
            if let count = contacts.contacts?.emails?.count, count > 0 {
                self.contactsList += (self.contacts?.contacts?.emails)!
            }
            self.tableView.reloadData()
        }
        
    }
    
    
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactsList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ContactsTVC
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.addressLabel.text = contactsList[indexPath.section]
        cell.contactImg.image = #imageLiteral(resourceName: "phone")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let i = indexPath.section
        if contactsList[i].contains("@") {
            email = []
            email.append(contactsList[i])
            sendEmail()
        } else{
            let phone = contactsList[i]
            let url = URL(string: "tel://\(phone)")!
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    func sendEmail(){
        let composer = MFMailComposeViewController()
        
        if MFMailComposeViewController.canSendMail() {
            composer.mailComposeDelegate = self
            composer.setToRecipients(email)
            composer.setSubject("Test Mail")
            composer.setMessageBody("Text Body", isHTML: false)
            present(composer, animated: true, completion: nil)
            
        }

    }
    func callFunc(){
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let a = UIView()
        a.backgroundColor = UIColor.clear
        return a
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
}

class ContactsTVC: UITableViewCell {
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var contactImg: UIImageView!
    
    
}
