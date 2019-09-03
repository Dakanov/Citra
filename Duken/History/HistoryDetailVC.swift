//
//  HistoryDetailVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 15.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Variables
    let images = [#imageLiteral(resourceName: "shampoo"),#imageLiteral(resourceName: "fruto nyanya")]
    var id = String()
    var order : Orders?
    var bask = [ProdObj()]

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getDetail()
        life()
        basketCount()
    }
    
    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var repeatButton: UIButton!
    // MARK: - Actions
   
    @IBAction func repeatPressed(_ sender: UIButton) {
        getAlert()
    }
    
    // MARK: - Functions
    func life(){
        
        repeatButton.layer.cornerRadius = 10
        repeatButton.shadow()
        repeatButton.applyGradient()
        
    }
    
    func getDetail(){
        
        getHistoryDetail(id: id) { (info) in
            self.order = info
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            if info != nil {
                self.dateLabel.text = "Дата покупки: \(self.DateFormat(date: (info.order?.dateOf)!))"
            }
        }
    }
    func getAlert(){
   
    
        let alert = UIAlertController(title: nil, message: "Добавить в", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Новый заказ", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            self.clearFunc()
        }))
        alert.addAction(UIAlertAction(title: "Корзину", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            self.addFunc()
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
   
    func addFunc(){ // add to basket without clearing
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self)
        bask = []
        if (result?.count)! > 0 {
            self.bask = Array(result!)
        }
        if let n = order?.order?.products?.count {
            if bask.count == 0 {
                for i in 0..<n {
                    let item = ProdObj()
                    item.id = (order?.order?.products?[i].idd?.id)!
                    item.amount = (order?.order?.products?[i].amount)!
                    try? realm?.write {
                        realm?.add(item)
                    }
                }
            }else {
                name1: for i in 0..<n {
                    let k = bask.count
                    neme2: for j in 0..<k {
                        let result = realm?.objects(ProdObj.self).filter("id == '\(bask[j].id)' AND amount > 0")
//                        if order?.order?.products?[i].idd?.id == bask[j].id {
                            if order?.order?.products?[i].idd?.id ==  Array(result!)[0].id {
                            try? realm?.write {
                                Array(result!)[0].amount += (order?.order?.products?[i].amount)!
                            }
                            break
                        } else  if (j == k - 1){
                            let item = ProdObj()
                            item.id = (order?.order?.products?[i].idd?.id)!
                            item.amount = (order?.order?.products?[i].amount)!
                            try? realm?.write {
                                realm?.add(item)
                            }
                        }
                        
                    }
                }
            }
          
        }
    }

    
    func clearFunc(){ // clear basket and add from order history
        bask = []
        let realm = try? Realm()
        let res = realm?.objects(ProdObj.self)
        try? realm?.write {
            realm?.delete(res!)
        }
        let item = ProdObj()
        if let n = order?.order?.products?.count {
            let prod = order?.order?.products
            if n > 0 {
                for i in 0..<n {
                    item.id =  (prod?[i].idd?.id)!
                    item.amount = (prod?[i].amount)!
                    try? realm?.write {
                        realm?.add(item)
                    }
                }
            }
        }
    }
    
    func basketCount() {
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self)
        bask = []
        if (result?.count)! > 0 {
            self.bask = Array(result!)
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let a = order?.order?.products?.count {
            return a
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DetailTVC
        let i = indexPath.row
        if let name = order?.order?.products?[i].idd?.name {
            cell.nameLabel.text = name
        }
        if let amount = order?.order?.products?[i].amount {
            cell.amountLabel.text = "Кол-во: \(amount) шт."
        }
        if let size = order?.order?.products?[i].idd?.measure?.scale {
            let unit = order!.order!.products![i].idd!.measure!.unit!
            let amount = order!.order!.products![i].idd!.measure!.amount!
            cell.prodVol.text = "\(size): \(amount) \(unit)"
        }
        
        cell.size()
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9294117647, blue: 0.8470588235, alpha: 1)
            cell.prodImg.image = #imageLiteral(resourceName: "shampoo")
        } else {
            cell.backgroundColor = UIColor.white
            cell.prodImg.image = #imageLiteral(resourceName: "fruto nyanya")
        }
        if let img = order?.order?.products?[i].idd?.img {
            let escapedString = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let imgUrl  = URL(string: "\(url)\(escapedString!)")
            cell.prodImg.sd_setImage(with: imgUrl, completed: nil)
        }
        return cell
    }
 
    
}

class DetailTVC: UITableViewCell {
    
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var prodVol: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var prodImg: UIImageView!
    
    func size() {
        prodImg.shadow()
        prodImg.layer.borderWidth = 0.5
        prodImg.layer.borderColor = UIColor.lightGray.cgColor
    }
}
