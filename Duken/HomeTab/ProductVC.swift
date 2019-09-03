//
//  ProductVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 09.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import RealmSwift

class ProductVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Variables
    var product : SingleProduct?
    var i = 0
    var counter = 0
    var basket = [ [Basket]]()
    var prodObj = [ProdObj()]
    var id = ""
    var inBasket = false
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.startLoading()
        prod()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        prodCountForBadge()
        basketCount()
    }

    // MARK: - Outlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Functions
    
    @objc func plusPressed(sender: UIButton) {
        prodCountForBadge()
        if inBasket {
            self.inBaskPlus()
        } else {
            outBaskPlus()
        }
        let i = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: i) as! infoTVC
        if let price = Int((product?.product?.price)!) {
            let summ = counter * price
            let z = summ.formattedWithSeparator
            let summl = "₸\(z)"
            cell.summLabel.text = summl
        }
        cell.countLabel.text = "\(counter)"
    }
    
    @objc func minusPressed(sender: UIButton) {
        if inBasket {
            inBaskMinus()
        } else {
            outBaskMinus()
        }
        let i = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: i) as! infoTVC
        cell.countLabel.text = "\(counter)"
        if let price = Int((product?.product?.price)!) {
            let summ = counter * price
            let z = summ.formattedWithSeparator
            let summl = "\(z) тг."
            cell.summLabel.text = summl
        }
    }
    
    @objc func addPressed(sender: UIButton) {
        prodCountForBadge()
        if counter < 1 {
            showAlert(title: "Внимание", message: "Укажите количество")
        } else {
            let item = ProdObj()
            item.id = self.id
            item.amount = counter
            let realm = try? Realm()
            let result = realm?.objects(ProdObj.self).filter("id == '\(id)' AND amount > 0")
            if let count = result?.count{
                if count < 1{
                    try? realm?.write {
                        realm?.add(item)
                        self.inBasket = true
//                        self.getAlert()
                        self.testAlert()
                    }
                }else{
                    try? realm?.write {
                        Array(result!)[0].amount = counter
                        self.inBasket = true
                    }
                }
            }
        }
    }

    func inBaskMinus(){
        
        counter -= 1
        let item = ProdObj()
        item.id = id
        item.amount = counter
        let i = IndexPath(row: 1, section: 0)
        let cell = tableView.cellForRow(at: i) as! infoTVC
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self).filter("id == '\(id)' AND amount > 0")
        if let count = result?.count{
            if count == 1{
                if Array(result!)[0].amount == 1 {
                    try? realm?.write {
                        realm?.delete(result!)
                        prodCountForBadge()
                        self.inBasket = false
                        cell.countLabel.text = "0"
                        cell.summLabel.text = "₸0"
                        cell.addButton.setTitle("Добавить в корзину", for: .normal)
                        cell.addButton.isEnabled = true
                    }
                } else {
                    try? realm?.write {
                        Array(result!)[0].amount = counter
                     
                    }
                }
            }
            
        }
    }
    
    func outBaskMinus(){
        if counter > 0 {
        self.counter -= 1
        }
    }
    func inBaskPlus(){
        counter += 1
        let item = ProdObj()
        item.id = id
        item.amount = counter
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self).filter("id == '\(id)' AND amount > 0")
        if let count = result?.count{
            if count < 1{
                try? realm?.write {
                    realm?.add(item)
                    self.inBasket = true
                }
            }else{
                try? realm?.write {
                    Array(result!)[0].amount = counter
                    self.inBasket = true
                }
            }
        }
        
 
    }
    func outBaskPlus(){
        self.counter += 1
    }
    
    func prod(){
        
        getSingleProduct(id: id) { (info) in
            self.product = info
            self.basketCount()
            self.tableView.reloadData()
            self.view.stopLoading()
        }
    }
        
    func basketCount(){
        let realm = try? Realm()
        if let id = (product?.product?.id) {
            let result = realm?.objects(ProdObj.self).filter("id == '\(id)' AND amount > 0")
            if (result?.count)! > 0 {
                inBasket = true
                if let count = result?[0].amount {
                    self.counter = count
                    let i = IndexPath(row: 1, section: 0)
                    let cell = tableView.cellForRow(at: i) as! infoTVC
                    cell.addButton.setTitle("Товар в корзине", for: .normal)
                    cell.addButton.isEnabled = false
                    cell.countLabel.text = "\(counter)"
                }
            } else {
                inBasket = false
            
                let i = IndexPath(row: 1, section: 0)
                let cell = tableView.cellForRow(at: i) as! infoTVC
                self.counter = 0
                cell.addButton.setTitle("Добавить в корзину", for: .normal)
                cell.addButton.isEnabled = true
                cell.countLabel.text = "0"
            }
        }
    }
    
    func getAlert(){
        let alert = UIAlertController(title: nil, message: "Товар добавлен в корзину", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func testAlert(){
        let alert = UIAlertController(title: nil, message: "Товар добавлен в корзину", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
       
        // show the alert
        self.present(alert, animated: true, completion: nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true)
        }
    }
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let i = indexPath.row
        if i == 0 {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! imageTVC
            if let imgs = product?.product?.desImg {
            cell1.imgs = imgs
            }
            cell1.start()
        return cell1
        } else {
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! infoTVC
            cell2.nameLabel.text = product?.product?.name
            if let size = product?.product?.idd?.measure?.scale {
                let unit = product?.product?.idd!.measure!.unit!
                let amount = product?.product?.idd!.measure!.amount!
                cell2.paramName.text = "\(size): \(amount) \(unit)"
            } else {
                cell2.paramName.text = ""
            }
            cell2.descriptionLabel.text = product?.product?.descriptionField
            if let price = product?.product?.price{
                if let x = Int(price){
                    let xx = x.formattedWithSeparator
                    let price = "₸\(xx)"
                    cell2.priceLabel.text = price
                    let summ = counter * x
                    let z = summ.formattedWithSeparator
                    let summl = "₸\(z)"
                    cell2.summLabel.text = summl
                }
            }
            if inBasket{
                cell2.addButton.setTitle("Товар в корзине", for: .normal)
                cell2.addButton.isEnabled = false
            } else {
                cell2.addButton.setTitle("Добавить в корзину", for: .normal)
                cell2.addButton.isEnabled = true
            }
            cell2.countLabel.text = "\(counter)"
            cell2.plusButton.tag = i
            cell2.plusButton.addTarget(self, action: #selector(plusPressed(sender:)), for: .touchUpInside)
            cell2.minusButton.tag = i
            cell2.minusButton.addTarget(self, action: #selector(minusPressed(sender:)), for: .touchUpInside)
            cell2.addButton.addTarget(self, action: #selector(addPressed(sender:)), for: .touchUpInside)
            cell2.counterView.layer.borderWidth = 0.4
            cell2.counterView.layer.borderColor = UIColor.lightGray.cgColor
            
            cell2.addButton.applyGradient()
            return cell2
        }
    }
}

class imageTVC: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var imgs = [""]
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var collectionView: UICollectionView!
    func start() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        pageControl.currentPage = 0
        pageControl.numberOfPages = imgs.count
        pageControl.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let n = imgs.count
        pageControl.numberOfPages = n
        return n
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!  imageCVC
        let i = indexPath.row
        let escapedString = imgs[i].addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let imgUrl  = URL(string: "\(url)\(escapedString!)")
        cell.prodImg.sd_setImage(with: imgUrl, completed: nil)
        cell.prodImg.layer.borderWidth = 0.5
        cell.prodImg.layer.borderColor = UIColor.lightGray.cgColor
        cell.prodImg.shadow()
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 5, 0, 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let w = collectionView.frame.size.width - 10
            let h = collectionView.frame.size.height
            return CGSize(width: w, height: h)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
            let  pageWidth = self.collectionView.frame.size.width;
            let  currentPage = self.collectionView.contentOffset.x / pageWidth;
            print("current Page is: \(currentPage)")
            print("page test 01: \(indexPath.item)")
//            pageControl.currentPage = Int(indexPath.item)
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let  pageWidth = self.collectionView.frame.size.width - 10;
        let  currentPage = self.collectionView.contentOffset.x / pageWidth;
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.x >= self.collectionView.frame.size.width - 10 {
            let witdh = scrollView.frame.width - (scrollView.contentInset.left*2)
            let index = scrollView.contentOffset.x / witdh
            let roundedIndex = round(index)
            print("current Page is: \(Int(roundedIndex))")
//            pageControl.currentPage = Int(roundedIndex)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
  
          pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

class infoTVC: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var paramName: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var plusButton: UIButton!
    @IBOutlet var minusButton: UIButton!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var summLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var counterView: UIView!
    
}

class imageCVC: UICollectionViewCell {
    @IBOutlet var prodImg: UIImageView!
}




