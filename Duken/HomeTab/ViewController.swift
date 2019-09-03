//
//  ViewController.swift
//  Duken
//
//  Created by Dakanov Sultan on 09.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper
import TRMosaicLayout
import SDWebImage

var width = UIScreen.main.bounds.size.width
var height = UIScreen.main.bounds.size.height


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, UITabBarControllerDelegate, UISearchBarDelegate {
    
    
    // MARK: - Variables
    var banner: Banners?
    var categories: Categories?
    var colors = [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
    var texts = ["Хлебобулочные изделия","Бытовая химия", "Напитки", "Молочные продукты", "Кондитерские", "Хозяйственные", "Моющие средства", "Напитки", "Хлебобулочные изделия"]
    var sectionImgs = [#imageLiteral(resourceName: "sloi10"),#imageLiteral(resourceName: "sloi9"),#imageLiteral(resourceName: "sloi11")]
    var banners = [#imageLiteral(resourceName: "0"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "2"),#imageLiteral(resourceName: "3"),#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "5")]
    var searchHeight = CGFloat()
    var selectedSection = -1
    var ok = false
    var view1Position = CGFloat()
    var view2Position = CGFloat()
    var searchProducts: Products?
    var h = CGFloat()
    var selectedRow = ""
    var keyWords = [String()]
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegates()
        swipe()
        Observers()
        viewLeading.constant =  0
        viewWidth.constant = width
        searchHeight = searchBar.frame.size.height
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        h = wallCollectionView.frame.size.height
        keyWords = []
    }

    override func viewWillAppear(_ animated: Bool) {
        prodCountForBadge()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
 
    @objc func hideKey(notification: Notification){
        searchBar.endEditing(true)
    }
    
    
    // MARK: - Outlets
    @IBOutlet var razdelCollectionView: UICollectionView!
    @IBOutlet var wallCollectionView: UICollectionView!
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var searchTop: NSLayoutConstraint!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var viewWidth: NSLayoutConstraint!
    @IBOutlet var viewLeading: NSLayoutConstraint!
    
    
    
    @IBOutlet var collectionViewTop: NSLayoutConstraint!
    @IBOutlet var searchBottom: NSLayoutConstraint!
    // MARK: - Actions
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController.tabBarItem.tag == 0 {
            homeList()
            let i = IndexPath(item: 0, section: 0)
            if categories != nil {
            self.wallCollectionView.scrollToItem(at: i, at: [.centeredVertically, .centeredHorizontally], animated: true)
            self.razdelCollectionView.scrollToItem(at: i, at: [.centeredVertically, .centeredHorizontally], animated: true)
            }
        }
    }
    // MARK: - SearchBar
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text != "" {
        searchRequest()
        } else {
            self.searchBar.endEditing(true)
        }
    }
    
    // MARK: - Functions
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSearch"{
            let sub: SearchVC = segue.destination as! SearchVC
            if keyWords.isEmpty {
                sub.products = self.searchProducts
                sub.searchText = self.searchBar.text!
            } else {
                sub.keyWords = self.keyWords
             sub.fromBanners()
            }
        }else if segue.identifier == "toProd" {
            let sub: ProductVC = segue.destination as! ProductVC
                sub.id = selectedRow
        }
    }
    
    func delegates() {
        searchBar.delegate = self
        categoryReq()
        tabBarController?.delegate = self
        bannersReq()
    }
    
    func Observers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.hide(notification:)), name: Notification.Name("scrollUp"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.unhide(notification:)), name: Notification.Name("scrollDown"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.toProd(notification:)), name: Notification.Name("toProduct"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideKey(notification:)), name: Notification.Name("hideKey"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.fromBasket(notification:)), name: Notification.Name("fromBasket"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideEnd(notification:)), name: Notification.Name("scrollUpEnd"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.unhideEnd(notification:)), name: Notification.Name("scrollDownEnd"), object: nil)
    }
    
    
    @objc func unhide(notification: Notification){ // expands searchBar
        
        if headerHeight.constant < 105 {
            self.headerHeight.constant += 2
        }
        else if headerHeight.constant > 95 {
            self.headerHeight.constant = 105
        }
        else {
            headerHeight.constant = 105
        }
        if self.searchTop.constant < 0 {
            self.searchTop.constant += 2
        }
       
        if searchBottom.constant > 0 {
            searchBottom.constant -= 1
            razdelCollectionView.reloadData()
        }
        if searchTop.constant > -30 {
            UIView.animate(withDuration: 1, animations: {
                self.searchBar.isHidden = false
            })
        }
        wallCollectionView.collectionViewLayout.invalidateLayout()
        self.view.layoutIfNeeded()
   
    }
    @objc func hide(notification: Notification){  // Hides searchBar
        let minHeight =  105 - self.searchBar.frame.size.height - 10
        if self.headerHeight.constant >  minHeight {
            self.headerHeight.constant -= 2
            if searchTop.constant  >  -self.searchHeight  {
                self.searchTop.constant -= 2
            }
            if searchBottom.constant < 14 {
                searchBottom.constant += 1
                razdelCollectionView.reloadData()
            }
        } else {
            self.headerHeight.constant = 105 - self.searchBar.frame.size.height - 10
            
        }
        if searchTop.constant < -30 {
            UIView.animate(withDuration: 1, animations: {
                self.searchBar.isHidden = true
            })
        }
        self.view.layoutIfNeeded()
    }
    
    @objc func unhideEnd(notification: Notification){
      self.view.layoutIfNeeded()
//        for _ in 0..<105 {
        if headerHeight.constant < 85 {
            self.headerHeight.constant += 1.7
        }
        else if headerHeight.constant > 84 {
            self.headerHeight.constant = 105
        }
        else {
            headerHeight.constant = 105
        }
        if self.searchTop.constant < 0 {
            self.searchTop.constant += 1.8
        }
        
        if searchBottom.constant > 0 {
            searchBottom.constant -= 1.8
            razdelCollectionView.reloadData()
        }
        if searchTop.constant > -30 {
            UIView.animate(withDuration: 1, animations: {
                self.searchBar.isHidden = false
            })
        }
        wallCollectionView.collectionViewLayout.invalidateLayout()
        self.view.layoutIfNeeded()
//        }
    }
    
    @objc func hideEnd(notification: Notification){
//        UIView.animate(withDuration: 0.1, animations: {
        let minHeight =  105 - self.searchBar.frame.size.height - 14
            self.searchTop.constant = -searchHeight
            self.searchBottom.constant = 14
            self.headerHeight.constant = minHeight
            razdelCollectionView.reloadData()
            self.searchBar.isHidden = true
            self.view.layoutIfNeeded()
//        })
    }
    
    @objc func toProd(notification: Notification) {
        if let i = notification.userInfo?["index"] as? String{
            print("get:  \(i)")
            self.selectedRow = i
        }
        performSegue(withIdentifier: "toProd", sender: self)
    }
    
    @objc func fromBasket(notification: Notification) {
        if let a = notification.userInfo?["select"] as? Int {
            let i = IndexPath(item: a, section: 0)
            navigationController?.popToRootViewController(animated: true)
            self.wallCollectionView.scrollToItem(at: i, at: [.centeredVertically, .centeredHorizontally], animated: true)
            self.razdelCollectionView.scrollToItem(at: i, at: [.centeredVertically, .centeredHorizontally], animated: true)
            selectedSection = a
            prodList()
        }
    }
    
 
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            searchBar.endEditing(true)
        }
    }
    
    // MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if categories?.categories?.count != nil {
            return (categories?.categories?.count)!
        }
        else {
            return 0 
        }

    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.wallCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! wallCVC
            let i = indexPath.row
            if let id = categories?.categories?[i].id {
                cell.id = id
                cell.i = i
                cell.getProd()
            }
//            cell.start()
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! sectionCVC
            let i = indexPath.row
            let j = i % 3
            let c = categories?.categories?[i]
            cell.nameLabel.text = categories?.categories?[i].name
            cell.backImg.image = sectionImgs[j]
            cell.nameLabel.backgroundColor = #colorLiteral(red: 0.5607843137, green: 0.6588235294, blue: 0, alpha: 0.55)
            cell.layer.cornerRadius = 10
            cell.nameLabel.shadowColor = UIColor.black
            cell.nameLabel.shadowOffset = CGSize(width: 0.5, height:0.5)
            if i == selectedSection {
                cell.nameLabel.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.5764705882, blue: 0, alpha: 1)
            }
            if let img = c?.image {
                let escapedString = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let url2 = URL(string: "\(url)\(escapedString!)")
                cell.backImg.sd_setImage(with: url2, completed: nil)
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == wallCollectionView {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.wallCollectionView {
            
        } else {
            let i = IndexPath(item: indexPath.row, section: 0)
            self.wallCollectionView.scrollToItem(at: i, at: [.centeredVertically, .centeredHorizontally], animated: true)
            selectedSection = indexPath.row
             prodList()
        }
    }
 
    
  
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView != self.razdelCollectionView {
            if ok {
                selectedSection = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
                razdelCollectionView.reloadData()
                let i = IndexPath(item: selectedSection, section: 0)
                self.razdelCollectionView.scrollToItem(at: i, at: [.centeredVertically, .centeredHorizontally], animated: true)
            }
        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if collectionView == self.wallCollectionView {
            let  pageWidth = self.wallCollectionView.frame.size.width;
            let  currentPage = self.wallCollectionView.contentOffset.x / pageWidth;
            print("current Page is: \(currentPage)")
            print("page test 01: \(indexPath.item)")
        } else {
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == wallCollectionView {
            return UIEdgeInsetsMake(0, 5, 0, 5)
        }
        else {
            return UIEdgeInsetsMake(0, 0, 0, 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.wallCollectionView {
            let w = collectionView.frame.size.width - 10
            let h = collectionView.frame.size.height
            return CGSize(width: w, height: h)
        }
        else {
            let font = UIFont.systemFont(ofSize: 17)
//            let w = texts[indexPath.row].widthOfString(usingFont: font) + 25
            return CGSize(width: 130, height: collectionView.frame.size.height)
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == self.wallCollectionView {
            return 1
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == wallCollectionView {
            return 10
        } else {
            return 3
        }
    }
}

class wallCVC: UICollectionViewCell,UICollectionViewDelegate, UICollectionViewDataSource, TRMosaicLayoutDelegate {
    
    //MARK: - Variables
    var colors = [#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1),#colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)]
    var prods = [#imageLiteral(resourceName: "fruto nyanya"), #imageLiteral(resourceName: "prod1-1"), #imageLiteral(resourceName: "shampoo")]
    var contentOff = CGFloat(0)
    var products : Products?
    var id = String()
    var i = -1
    var enought = false
    var refreshControl = UIRefreshControl()
    
    //MARK: - Life
    func start(){
     
        let mosaicLayout = TRMosaicLayout()
        mosaicLayout.delegate = self
        
        if let n = products?.products?.count {
            if n > 0 {
                collectionView.collectionViewLayout = mosaicLayout
                let i = IndexPath(row: 0, section: 0)
                // MARK:- UNCOMMENT ROW
                collectionView.scrollToItem(at: i, at: UICollectionViewScrollPosition.top, animated: false)
            }
        }
        for _ in 0..<105 {
            NotificationCenter.default.post(name: Notification.Name("scrollDownEnd"), object: nil)
        }
        collectionView.alwaysBounceVertical = true
        
        collectionView.bounces  = true
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.collectionView.addSubview(refreshControl)
    }
    
    @objc func didPullToRefresh() {
        self.enought = false
        getProd()
        // For End refrshing
        
        print("remove ")
    }
    //MARK: - Outlets
    @IBOutlet var collectionView: UICollectionView!
    //MARK: - Actions
    
    //MARK: - Functions
    func getProd() {

        getMainProducts(skip: "0", id: id) { (info) in
            self.products = info
            self.collectionView.delegate = self
            self.collectionView.dataSource = self
            //        getProd()
            self.refreshControl.endRefreshing()
            self.refreshControl.removeFromSuperview()
            self.collectionView.reloadData()
            if let n = info.products?.count {
                if n < 27 {
                    self.enought = true
                    self.collect()
                }
                if n > 0 {
                self.start()
            } else {
                self.collectionView.reloadData()
            }
            }
            self.enought = false
 
        }
    }
    
    func collect(){
        if let n = products?.products?.count {
            let a = n % 9
            if a != 0 {
                let b = 9 - a
                for i in 0..<b {
                    let p = products!.products![i]
                    products?.products?.append(p)
                }
                self.collectionView.reloadData()
            }
        }
    }
    
    func loadData() {
        if let skip = products?.products?.count {
            getMainProducts(skip: "\(skip)", id: id) { (info) in
                if let a = info.products?.count {
                    for i in 0..<a {
                        self.products?.products?.append(info.products![i])
                    }
                    if a < 27 {
                        self.enought = true
                        self.collect()
                    }
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Functions
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let y = scrollView.panGestureRecognizer.translation(in: scrollView.superview).y
            print(y)
            if scrollView.contentOffset.y < 80 {
                NotificationCenter.default.post(name: Notification.Name("scrollDownEnd"), object: nil)
            } else {
            if y > 90 {
                NotificationCenter.default.post(name: Notification.Name("scrollDown"), object: nil)
            } else if y < -30{
                NotificationCenter.default.post(name: Notification.Name("scrollUp"), object: nil)
            }
            }
        }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: Notification.Name("hideKey"), object: nil)
    }
 
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        var n = 27
        if products?.products?.count != nil {
            return  (products?.products?.count)!
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! prodcutCVC
        let i = indexPath.row
        let product = products?.products?[i]
        let j = i % 3
        cell.priceLabel.font = cell.priceLabel.font.withSize(13)
        
        if i % 9 == 0 {
            cell.priceLabel.font = cell.priceLabel.font.withSize(15)
        }
        if let img = products?.products?[i].img {
            let escapedString = img.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let imgUrl  = URL(string: "\(url)\(escapedString!)")
            cell.productImg.sd_setImage(with: imgUrl, completed: nil)
        }
        if let price =  product?.price {
            let x = Int(price)!.formattedWithSeparator
            cell.priceLabel.text = "₸\(x)"
        }
//        cell.productImg.image = prods[j]
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        if i == (products?.products?.count)! - 1 {
            if !enought {
                self.loadData()
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = products?.products?[indexPath.row].id
        let info:[String: String] = ["index": id!]
        
        NotificationCenter.default.post(name: Notification.Name("toProduct"), object: nil, userInfo: info)
        
    }
    
    //MARK: - TRMosaicLayout
    func widthForSmallMosaicCell() -> CGFloat {
        let w = (collectionView.frame.size.width) / 3
        return w
    }
    
    func collectionView(_ collectionView: UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath: IndexPath) -> TRMosaicCellType {
        return indexPath.item % 9 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
    }
    
    func heightForSmallMosaicCell() -> CGFloat {
        let w = (collectionView.frame.size.width) / 3
        return w
    }
    
    func getMainProducts(skip: String, id: String,completionHandler: @escaping (_ params: Products) -> ()) {
        
        
        Alamofire.request("\(url)api/lists/\(skip)/27/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Products>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    print("Произошла какая-то ошибка")
                }
            } else {
                print("Сервер наебнулся")
            }
        }
    }
}
class prodcutCVC: UICollectionViewCell {
    @IBOutlet var productImg: UIImageView!
    @IBOutlet var priceLabel: UILabel!
}

class sectionCVC: UICollectionViewCell {
    @IBOutlet var backImg: UIImageView!
    @IBOutlet var nameLabel: UILabel!
}

class TVC: UITableViewCell {
    @IBOutlet var prodImg: UIImageView!
}

extension UILabel {
    func lblShadow(){
        self.textColor = UIColor.white
        self.layer.masksToBounds = true
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 4, height: 3)
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}


