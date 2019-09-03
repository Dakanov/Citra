//
//  BasketVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 16.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import RealmSwift
import SDWebImage

class BasketVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Variables
    var texts = ["Хлебобулочные изделия","быт химия", "напитки", "Молочные продукты", "Кондитерские", "Хозяйственные", "Моющие средства", "напитки", "напитки"]
    var sectionImgs = [#imageLiteral(resourceName: "sloi10"),#imageLiteral(resourceName: "sloi9"),#imageLiteral(resourceName: "sloi11")]
    var categories : Categories?
    var bask = [ProdObj()]
    var ids = [String()]
    var products: Products?
    var total = 0
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        life()
        
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        basketCount()
    }
    // MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var orderButton: UIButton!
    @IBOutlet var summLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func orderPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ToOrder", sender: self)
    }
    
    @objc func minusPressed(sender: UIButton) {
        prodCountForBadge()
        let tag = sender.tag
        let id  = bask[tag].id
        let counter = bask[tag].amount
        let i = IndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: i) as! basketTVC
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self).filter("id == '\(id)'")
        if let count = result?.count{
            if count >= 1{
                if Array(result!)[0].amount == 1 {
                    let alert = UIAlertController(title: "", message: "Удалить товар из корзины?", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { action in
                        try? realm?.write {
                            realm?.delete(result!)
                            self.basketCount()
                        }
                    }))
                    alert.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
                    
                    self.present(alert, animated: true, completion: nil)
                } else {
                    try? realm?.write {
                        Array(result!)[0].amount = counter - 1
                        if let price = products?.products?[tag].price{
                            let summ = Int(price)! * Array(result!)[0].amount
                            self.total -= Int(price)!
                            let xxx = total.formattedWithSeparator
                            self.summLabel.text = "₸\(xxx)"
                            let xx = summ.formattedWithSeparator
                            let price1 = "₸\(xx)"
                            cell.summLabel.text = price1
                        }
                        cell.countLabel.text = "\(counter - 1)"
                    }
                }
            }
            
        }
    }
    
    @objc func plusPressed(sender: UIButton) {
        prodCountForBadge()
        let tag = sender.tag
        let id  = bask[tag].id
        let counter = bask[tag].amount
        let i = IndexPath(row: tag, section: 0)
        let cell = tableView.cellForRow(at: i) as! basketTVC
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self).filter("id == '\(id)'")
        if let count = result?.count{
            if count > 0{
                try? realm?.write {
                    Array(result!)[0].amount = counter + 1
                    if let price = products?.products?[tag].price{
                        let summ = Int(price)! * Array(result!)[0].amount
                        let xx = summ.formattedWithSeparator
                        let price1 = "₸\(xx)"
                        self.total += Int(price)!
                        let xxx = total.formattedWithSeparator
                        self.summLabel.text = "₸\(xxx)"
                        cell.summLabel.text = price1
                        cell.countLabel.text = "\(counter + 1)"
                    }
                }
            }
        }
    }
    
    // MARK: - Functions
    func basketCount() {
        prodCountForBadge()
        orderButton.isEnabled = false
        let realm = try? Realm()
        bask = []
        let result = realm?.objects(ProdObj.self)
        if (result?.count)! > 0 {
            self.bask = Array(result!)
            ids = []
            for i in 0..<bask.count {
                ids.append("\(bask[i].id)")
            }
            if ids != [] {
                self.view.startLoading()
                self.basketReq()
            }
        } else {
            self.summLabel.text = "₸0"
            products?.products = []
            tableView.reloadData()
        }
    }
    
    func removeBasket(){
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self)
        try? realm?.write {
            realm?.delete(result!)
        }
    }
    
    
    func categoryReq(){
        getCategories { (info) in
            self.categories = info
            if self.categories?.categories?.count != nil {
                if (self.categories?.categories?.count)! > 0 {
                    self.collectionView.delegate = self
                    self.collectionView.dataSource = self
                }
            }
        }
    }
    
    func basketReq(){
        let parameters = ["product": ids] as [String : AnyObject]
        
        getBasketProduct(parameters: parameters) { (info) in
            self.products = info
            if info.products?.count == 0 {
                self.removeBasket()
            }
            var ap = info.products
            ap = []
            if ((self.products?.products?.count) != nil) {
                if (self.products?.products?.count)! > 0 {
                    self.orderButton.isEnabled = true
                    
                    if self.ids.count != info.products?.count {
                        var arr = [""]
                        arr = []
                        for i in 0..<(info.products?.count)! {
                            let j = info.products?[i].id
                            arr.append(j!)
                        }
                        self.ids = arr
                    }
                    for id in self.ids {
                        for item in (self.products?.products)! {
                            if id == item.id {
                                ap?.append(item)
                            }
                        }
                    }
                    self.products?.products = ap
                    self.tableView.reloadData()
                    self.view.stopLoading()
                } else {
                    self.tableView.reloadData()
                    self.view.stopLoading()
                }
                
            }
        }
    }
    
    func life() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        categoryReq()
        basketReq()
        orderButton.applyGradient()
        orderButton.shadow()
    }
    
    func selectedSections(selected: Int) {
        tabBarController?.selectedIndex = 0
        let info:[String: Int] = ["select": selected]
        NotificationCenter.default.post(name: Notification.Name("fromBasket"), object: nil, userInfo: info)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToOrder"{
            let sub: CheckOutVC = segue.destination as! CheckOutVC
            sub.totalProd = self.total
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var n = 0
        total = 0
        if products?.products?.count != nil {
            n = (products?.products?.count)!
        }
        return n
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! basketTVC
        let i = indexPath.row
        let product = products?.products?[i]
        cell.size()
        cell.minusButton.tag = i
        cell.minusButton.addTarget(self, action: #selector(minusPressed(sender:)), for: .touchUpInside)
        cell.plusButton.tag = i
        cell.plusButton.addTarget(self, action: #selector(plusPressed(sender:)), for: .touchUpInside)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9294117647, blue: 0.8470588235, alpha: 1)
            cell.prodImg.image = #imageLiteral(resourceName: "shampoo")
        } else {
            cell.backgroundColor = UIColor.white
            cell.prodImg.image = #imageLiteral(resourceName: "fruto nyanya")
        }
        if let img = product?.img {
            let escapedString = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let imgUrl  = URL(string: "\(url)\(escapedString!)")
            cell.prodImg.sd_setImage(with: imgUrl, completed: nil)
        }
        if let price =  products?.products?[i].price{
            if let x = Int(price){
                let xx = x.formattedWithSeparator
                let price = "₸\(xx)"
                cell.priceLabel.text = price
            }
            let summ = Int(price)! * bask[i].amount
            let xx = summ.formattedWithSeparator
            let price = "₸\(xx)"
            self.total += summ
            let xxx = total.formattedWithSeparator
            self.summLabel.text = "₸\(xxx)"
            cell.nameLabel.text = products?.products?[i].name
            cell.summLabel.text = price
        }
        cell.countLabel.text = "\(bask[i].amount)"
        return cell
    }
    
    // MARK: - COllectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if categories?.categories?.count != nil {
            return (categories?.categories?.count)!
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! basketSections
        let i = indexPath.row
        let j = i % 3
        let c = categories?.categories?[i]
        cell.nameLabel.text = c?.name
        if let img = c?.image {
            let escapedString = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let url2 = URL(string: "\(url)\(escapedString!)")
            cell.backImg.sd_setImage(with: url2, completed: nil)
        }
        cell.backImg.image = sectionImgs[j]
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSections(selected: indexPath.row)
        
    }
    
}

class basketTVC : UITableViewCell {
    @IBOutlet var prodImg: UIImageView!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var summLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var numberView: UIView!
    
    func size() {
        prodImg.shadow()
        prodImg.layer.borderWidth = 0.5
        prodImg.layer.borderColor = UIColor.lightGray.cgColor
        numberView.layer.borderWidth = 0.5
        numberView.layer.borderColor = UIColor.lightGray.cgColor
    }
}
class basketSections : UICollectionViewCell {
    @IBOutlet var backImg: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    
}

extension BasketVC {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130, height: collectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}
