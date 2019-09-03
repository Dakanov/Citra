//
//  ProfileVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 14.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    // MARK: - Variables
    var n = 3
    var user: Profile?
    var address: ShopAdresses?
    var cards: Cards?
    var addressId = ""
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTableView.delegate = self
        addressTableView.dataSource = self
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        getUserReq()
        size()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getMyAddress()
        getMyCards()
    }

    // MARK: - Outlets
    
    @IBOutlet var addressTableHeight: NSLayoutConstraint!
    @IBOutlet var addressTableView: UITableView!
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var mainHeight: NSLayoutConstraint!
    @IBOutlet var addAddressOutlet: UIButton!
    
    @IBOutlet var logoutOutlet: UIButton!
    
    // MARK: - Actions
    @IBAction func addAddressPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ToMyAddress", sender: self)
    }

    @IBAction func logoutPressed(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "token")
        performSegue(withIdentifier: "Logout", sender: self)
    }
    
    // MARK: - Functions
    func getUserReq(){
        getUserData { (profile) in
            self.user = profile
            self.setData()
        }
    }
    func getMyAddress(){
        getUserAddress { (info) in
            self.address = info
            self.addressTableView.reloadData()
            self.tableHeight()
        }
    }
    func getMyCards(){
        getUserCards { (info) in
            self.cards = info
            
            self.tableHeight()
        }
    }
    func setData(){
        nameLabel.text = user?.user?.name
    }
    func size() {
        addAddressOutlet.shadow()
        addAddressOutlet.applyGradient()
        logoutOutlet.blackGrad()
        logoutOutlet.shadow()
        self.navigationItem.title = "Мой профиль"
    }
    func tableHeight() {
        var cardHeigh = 0
        if cards?.cards?.count != nil {
            cardHeigh = (cards?.cards?.count)!
        }
        var addressHeight = 0
        if address?.adresses?.count != nil {
            addressHeight = (address?.adresses?.count)!
        }
        mainHeight.constant -=  addressTableHeight.constant
        addressTableHeight.constant = 0
        addressTableHeight.constant = 54 * CGFloat(addressHeight) + 10
        mainHeight.constant += addressTableHeight.constant
        view.layoutIfNeeded()
    }

    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == addressTableView {
            if address?.adresses?.count != nil {
                return (address?.adresses?.count)!
            } else {
                return 0
            }
        } else {
            if cards?.cards?.count != nil {
                return (cards?.cards?.count)!
            }else {
                return 0
            }
        }
        return n
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == addressTableView {
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! AddressTVC
            cell1.layer.borderWidth = 0.5
            let i = indexPath.section
            if let str = address?.adresses?[i].street {
                if let num = address?.adresses?[i].houseNum {
                    cell1.addressLabel.text = "\(str) \(num)"
                }
            }
            cell1.cellShadow()
            return cell1
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! CardsTVC
            cell2.layer.borderWidth = 0.3
            cell2.layer.borderColor = UIColor.lightGray.cgColor
            let i = indexPath.section
            let c = cards?.cards?[i]
            if let number = c?.cardLastFour {
                cell2.cardNumber.text = "**** **** **** \(number)"
            }
            cell2.cellShadow()
            return cell2
        }
    }
   
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            return true
    }
 
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        if tableView != addressTableView {
        let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
            let id = self.cards?.cards?[indexPath.section].id
            self.cards?.cards?.remove(at: indexPath.section)
            self.deleteCard(id: id!, i: indexPath)
        }
        return [delete]
        } else {
            let delete = UITableViewRowAction(style: .destructive, title: "Удалить") { (action, indexPath) in
                let id = self.address?.adresses![indexPath.section].id
                self.address?.adresses?.remove(at: indexPath.section)
                self.addressTableView.reloadData()
                self.deleteAddress(id: id!, i: indexPath)
            }
            return [delete]
        }
    }
    func deleteCard(id: String, i: IndexPath){
        let parameters = ["_id": id] as [String: AnyObject]
        cardDelete(parameters: parameters) { (info) in
        }
    }
    func deleteAddress(id: String, i: IndexPath){
        let parameters = ["_id": id] as [String: AnyObject]
        addressDelete(parameters: parameters) { (info) in
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let a = UIView()
        a.backgroundColor = UIColor.clear
        return a
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

class AddressTVC: UITableViewCell {
    @IBOutlet var addressLabel: UILabel!
    
}
class CardsTVC: UITableViewCell {
    @IBOutlet var cardNumber: UILabel!
    
}
