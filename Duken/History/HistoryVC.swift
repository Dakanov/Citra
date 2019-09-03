//
//  HistoryVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 15.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit

class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // MARK: - Variables
    var history : ProductHistoryRootClass?
    var selectedId = ""
    var enought = false
    var priceIncrease = false
    var dateIncrease = false
    var sort = ""
    
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        getHistoryReq()
        size()
        
    }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    // MARK: - Outlets
    @IBOutlet var byPriceImg: UIImageView!
    @IBOutlet var byDateImg: UIImageView!
    @IBOutlet var byDateOutlet: UIButton!
    @IBOutlet var byMonthOutlet: UIButton!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Actions
    @objc func detailPressed(sender: UIButton) {
        let tag = sender.tag
        selectedId = (history?.histories?[tag].id)!
        performSegue(withIdentifier: "ToDetail", sender: self)
    }
    
    @IBAction func sortByPricePressed(_ sender: UIButton) {
        priceIncrease = !priceIncrease
        byDateImg.image = nil
        if priceIncrease {
            if let i = UIImage(named: "grayTri"){
                if let a = self.byPriceImg {
                    a.image = i
                }
            }
            
            sort = "summ"
        } else {
            if let i = UIImage(named: "grayTriUp"){
                if let a = self.byPriceImg {
                    a.image = i
                }
            }
            sort = "-summ"
        }
        getHistoryReq()
//        sortByPrice()
        tableView.reloadData()
    }
    @IBAction func sortByDatePressed(_ sender: UIButton) {
        dateIncrease = !dateIncrease
        self.byPriceImg.image = nil
        if dateIncrease {
            self.byDateImg.image = #imageLiteral(resourceName: "grayTriUp")
            sort = "createdAt"
        } else {
            self.byDateImg.image = #imageLiteral(resourceName: "grayTri")
            sort = "-createdAt"
        }
        
        getHistoryReq()
//        sortByDate()
        tableView.reloadData()
    }
    
    // MARK: - Functions
    func sortByPrice(){
        byDateImg.image = nil
        history?.histories?.sort(by: { (h0, h1) -> Bool in
            if priceIncrease {
                self.byPriceImg.image = #imageLiteral(resourceName: "grayTri")
                return h0.summ! > h1.summ!
            } else {
                self.byPriceImg.image = #imageLiteral(resourceName: "grayTriUp")
                return h0.summ! < h1.summ!
            }
        })
    }
    func sortByDate() {
        byPriceImg.image = nil
        history?.histories?.sort(by: { (h0, h1) -> Bool in
            let t0 = getTimestamp(date: h0.dateOf!)
            let t1 = getTimestamp(date: h1.dateOf!)
            if dateIncrease {
                self.byDateImg.image = #imageLiteral(resourceName: "grayTri")
                return t0 > t1
            } else {
                self.byDateImg.image = #imageLiteral(resourceName: "grayTriUp")
                return t0 < t1
            }
            
            
        })
    }
    
    func getHistoryReq(){
        self.view.startLoading()
        getHistory(skip: "0", limit: "15", sort: sort) { (info) in
            self.history = info
            if (info.histories?.count)! < 15 {
                self.enought = true
            }
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
            self.view.stopLoading()
        }
    }
    func loadData(){
        if let a = history?.histories?.count {
            getHistory(skip: "\(a)", limit: "15", sort: sort) { (info) in
                for i in 0..<(info.histories?.count)! {
                    self.history?.histories?.append(info.histories![i])
                }
                if (info.histories?.count)! < 15 {
                    self.enought = true
                }
                self.tableView.reloadData()
            }
        }

    }
    
    func size() {
        
//        tableView.delegate = self
//        tableView.dataSource = self
        byPriceImg.image = nil
        self.navigationItem.title = "История"
        byDateOutlet.layer.borderWidth = 1
        byMonthOutlet.layer.borderWidth = 1
        byMonthOutlet.layer.borderColor = UIColor.lightGray.cgColor
        byDateOutlet.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail"{
            let sub: HistoryDetailVC = segue.destination as! HistoryDetailVC
            sub.id = self.selectedId
        }
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let a =  history?.histories?.count {
            if a > 0 {
                return a
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HistoryTVC
        let i = indexPath.row
        cell.size()
        let h = history?.histories?[i]
        if let a = history?.histories?[i].products?.count {
            var list = ""
            for i in 0..<a {
                if let name = history?.histories?[indexPath.row].products?[i].idd?.name {
                if i + 1 == a {
                list += "\(name) "
                }else {
                    list += "\(name), "
                }
            }
                cell.listLabel.text = list
            }
            let a = history!.histories![i].summ!
            let b = a.formattedWithSeparator
            cell.summLabel.text = "₸\(b)"
            cell.addressLabel.text = h?.adress
            if i == a - 1 {
                if !enought {
                    self.loadData()
                }
            }
        }
        if let date = h?.dateOf {
            cell.dateLabel.text = DateFormat(date: date)
        }
        
        cell.moreButton.tag = indexPath.row
        cell.moreButton.addTarget(self, action: #selector(detailPressed(sender:)), for: .touchUpInside)
        return cell
    }
  
 
    
    
}
class HistoryTVC: UITableViewCell {
    @IBOutlet var summLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var backView: UIView!
    @IBOutlet var listLabel: UILabel!
    @IBOutlet var moreButton: UIButton!
    
    func size() {
        backView.shadow()
        backView.layer.borderWidth = 0.4
        backView.layer.borderColor = UIColor.lightGray.cgColor
        moreButton.applyGradient()
        moreButton.shadow()
        moreButton.layer.cornerRadius = 10
    }
}








