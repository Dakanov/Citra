//
//  ViewController2.swift
//  Duken
//
//  Created by Dakanov Sultan on 13.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import SDWebImage

extension ViewController{
    // MARK: - Requests
    
    func bannersReq(){
        getBanners { (info) in
            self.banner = info
            if self.banner?.banners?.count != nil {
                if (self.banner?.banners?.count)! > 0 {
                    self.tableView.delegate = self
                    self.tableView.dataSource = self
                    self.tableView.reloadData()
                }
            }
        }
    }
    func categoryReq(){
        getCategories { (info) in
            self.categories = info
            if self.categories?.categories?.count != nil {
                if (self.categories?.categories?.count)! > 0 {
                    self.razdelCollectionView.delegate = self
                    self.razdelCollectionView.dataSource = self
                    self.razdelCollectionView.reloadData()
                    self.wallCollectionView.delegate = self
                    self.wallCollectionView.dataSource = self
                }
            }
            
        }
    }
    func searchRequest(){
        let parameters = ["text": searchBar.text,
                          "limit": "24",
        "skip": "0"] as [String: AnyObject]
        searchReq(parameters: parameters) { (info) in
            self.searchProducts = info
            if let count = self.searchProducts?.products?.count {
                if count > 0 {
                    self.performSegue(withIdentifier: "ToSearch", sender: self)
                } else {
                    self.showAlert(title: "Внимание", message: "По вашему запросу ничего не найдено")
                    print("По вашему запросу ничего не найдено")
                }
            }
        }
    }
    // MARK: - TableView
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == UISwipeGestureRecognizerDirection.right {
            if selectedSection == 0  {

                    homeList()
            }
        }
        else if gesture.direction == UISwipeGestureRecognizerDirection.left {
            selectedSection = 0
            prodList()
        }
    }
    func swipe(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeUp.direction = .up
        self.view.addGestureRecognizer(swipeUp)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    func prodList() {
        ok = true
        razdelCollectionView.reloadData()
        view1Position = -width
        view2Position = 4
        animation()
    }
    func homeList() {
        ok = false
        selectedSection = -1
        razdelCollectionView.reloadData()
        view1Position =  0
//        view2Position = width + 10
        animation()
    }
    func animation(){
        view.layoutIfNeeded()
        viewLeading.constant = view1Position
//        viewTrailing.constant = view2Position
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return (banner?.banners?.count)!
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TVC
        let i = indexPath.section
        if let imageUrl = banner?.banners?[i].img {
            let escapedString = imageUrl.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let url2 = URL(string: "\(url)\(escapedString!)")
            cell.prodImg.sd_setImage(with: url2, completed: nil)
        }
//        cell.prodImg.image = banners[i]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.keyWords = (banner?.banners?[indexPath.section].keyWords!)!
        if !keyWords.isEmpty {
            self.performSegue(withIdentifier: "ToSearch", sender: self)
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let a = UIView()
        return a
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
}

