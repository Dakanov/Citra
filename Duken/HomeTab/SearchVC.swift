//
//  SearchVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 06.09.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit

class SearchVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout , UIScrollViewDelegate, UISearchBarDelegate{

    // MARK: - Variables
    var prods = [#imageLiteral(resourceName: "fruto nyanya"), #imageLiteral(resourceName: "prod1-1"), #imageLiteral(resourceName: "shampoo")]
    var products: Products?
    var skip = 24
    var enought = false
    var i = ""
    var searchText = ""
    var keyWords = [String()]
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        searchBar.text = searchText
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
    }

    // MARK: - Outlets

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Actions
    
    // MARK: - Functions
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRequest()
        searchBar.endEditing(true)
    }
    func searchRequest(){
        let parameters = ["text": searchBar.text,
                          "limit": "24",
                          "skip": "0"] as [String: AnyObject]
        searchReq(parameters: parameters) { (info) in
           if let count = info.products?.count {
                if count > 0 {
                    self.products = info
                    self.collectionView.reloadData()
                } else {
                    self.showAlert(title: "Внимание", message: "По вашему запросу ничего не найдено")
                }
            }
        }
    }
    
    func loadData(){
        skip = (self.products?.products?.count)!
        let parameters = ["text": searchBar.text,
                          "limit": "24",
                          "skip": skip] as [String: AnyObject]
        searchReq(parameters: parameters) { (info) in
            if let a = info.products?.count {
                for i in 0..<a {
                    self.products?.products?.append(info.products![i])
                }
                if a < 24 {
                    self.enought = true
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func fromBanners() {
        let parameters = ["keyWords" : keyWords] as [String: AnyObject]
        searchFromBanner(parameters: parameters) { (products) in
            self.products = products
            self.enought = true
            self.collectionView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.endEditing(true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToProdFromSearch"{
            let sub: ProductVC = segue.destination as! ProductVC
            sub.id = self.i
        }
    }
    // MARK: - CollectionView
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if products?.products?.count != nil {
        return (products?.products?.count)!
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCVC
        let i = indexPath.row
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if let price = products?.products?[i].price{
            if let x = Int(price){
                let xx = x.formattedWithSeparator
                let price = "₸\(xx)"
                cell.priceLabel.text = price
            }
        }
        if let img = products?.products?[i].img {
            let escapedString = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let url2 = URL(string: "\(url)\(escapedString!)")
            cell.productImage.sd_setImage(with: url2, completed: nil)
        } else {
            cell.productImage.image = nil
        }
        if i == (products?.products?.count)! - 1 {
            if !enought {
                self.loadData()
            }
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.i = (products?.products?[indexPath.row].id)!
        performSegue(withIdentifier: "ToProdFromSearch", sender: self)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let w = (collectionView.frame.size.width - 3 ) / 3
        let h = w
        return CGSize(width: w, height: h)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    
}
class SearchCVC: UICollectionViewCell {
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var productImage: UIImageView!
}

