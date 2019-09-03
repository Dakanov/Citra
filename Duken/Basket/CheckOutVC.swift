//
//  CheckOutVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 17.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import RealmSwift
import MapKit

class CheckOutVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate, UIWebViewDelegate {

    // MARK: - Variable
    var payByCard = false
    var getByDelivery = false
    let date = NSDate()
    let calendar = NSCalendar.current
    var locationManager = CLLocationManager()
    var totalProd = 0
    var address: ShopAdresses?
    var myAddress: ShopAdresses?
    var shopAddress: ShopAdresses?
    var bask = [ProdObj()]
    var time = TimeInterval()
    var myLat = ""
    var myLng = ""
    var deliveryCoeficient = 120
    var products = [[String: AnyObject]]()
    var deliveryDate = ""
    var cryptoCrypt : String?
    var cards: Cards?
    var cardsId = ""
    var htmlCode = ""
    var w = UIWebView()
    var tranzId = String()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 0.4939995408, green: 0.6309534907, blue: 0, alpha: 1)
        size()
        textSets()
        life()
        basketCount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        getMyAddress()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            addressView.removeFromSuperview()
            carListView.removeFromSuperview()
    }
    
    // MARK: - Outlets
    @IBOutlet var carListView: UIView!
    @IBOutlet var cardTableView: UITableView!
    @IBOutlet var prodSummLabel: UILabel!
    @IBOutlet var deliveryPriceLabel: UILabel!
    @IBOutlet var summLabel: UILabel!
    @IBOutlet var addAddress: UIButton!
    @IBOutlet var checkOut: UIButton!
    @IBOutlet var pickupButtonView: UIButton!
    @IBOutlet var deliveryButtonView: UIButton!
    @IBOutlet var addressTableView: UITableView!
    @IBOutlet var addressView: UIView!
    @IBOutlet var newCardButton: UIButton!
    @IBOutlet var newAddressButton: UIButton!
    @IBOutlet var deliveryTimeOutlet: UIButton!
    @IBOutlet var datePickerView: UIView!
    @IBOutlet var timeView: UIView!
    @IBOutlet var saveOutlet: UIButton!
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet weak var cardBottomView: UIView!
    @IBOutlet var anotherTime: UIButton!
    @IBOutlet weak var addCardButtomBottom: NSLayoutConstraint!
    // MARK: - Actions
    
    @IBOutlet weak var cardTableBottom: NSLayoutConstraint!
    @IBAction func addNewCardPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddNewCard", sender: self)
        carListView.removeFromSuperview()
    }
    @IBAction func addNewAddressPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toAddNewAddress", sender: self)
    }
    @IBAction func checkOutPressed(_ sender: UIButton) {
//        if getByDelivery == false {
//            performSegue(withIdentifier: "ToShopMap", sender: self)
//        }
//        checkOutReq()
        checkOutCheck()
    }
    
    @IBAction func addAddressPressed(_ sender: UIButton) {
        guard getByDelivery else {
        attentionAlert(title: "", message: "Дорогой клиент! Просим обратить внимание, что доставка продуктов за пределами квадрата улиц Назарбаева-Аль-Фараби-Сейфуллина-Сатпаева осуществляется в тестовом режиме. В связи с этим время фактической доставки может отличаться от выбранного вами. Мы с Вами свяжемся в ближайшее время.")
            return
        }
        get1000Alert()
    }
    
    @IBAction func addCardPressed(_ sender: UIButton) {
        view.addSubview(carListView)
        reloadCardTableView()
    }
    
    
    private func reloadCardTableView() {
        let screenWidth = UIScreen.main.bounds.width
        if cards?.cards?.count == nil || cards?.cards?.count == 0 {
            cardTableBottom.constant = -200
            cardTableView.isHidden = true
            cardBottomView.frame = CGRect(x: 16, y: 90, width: screenWidth - 32, height: 80)
        } else {
            cardTableBottom.constant = 0
            cardTableView.isHidden = false
        }
    }
    

    
    @IBAction func deliveryPressed(_ sender: UIButton) {
        newAddressButton.isHidden = false
        addressId = ""
        pickupButtonView.backgroundColor = UIColor.clear
        deliveryButtonView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.5764705882, blue: 0, alpha: 1)
        addressLabel.text = "Адрес доставки:"
        self.address = self.myAddress
        addressTableView.reloadData()
        getByDelivery = true
    }
    
    @IBAction func pickUpPressed(_ sender: UIButton) {
        newAddressButton.isHidden = true
        self.address = self.shopAddress
        addressTableView.reloadData()
        pickupButtonView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.5764705882, blue: 0, alpha: 1)
        deliveryButtonView.backgroundColor = UIColor.clear
        addressId = ""
        getByDelivery = false
        let m = Int(minDist)
        let xxx = m.formattedWithSeparator
        deliveryPriceLabel.text = "Сумма доставки: ₸\(0)"
        addressLabel.text = "Адрес магазина:"
        let x = totalProd.formattedWithSeparator
        summLabel.text = "Итого к оплате: ₸\(x)"
    }
    
    @IBAction func deliveryTimePressed(_ sender: UIButton) {
        view.addSubview(datePickerView)
    }
    
    @IBAction func saveTimePressed(_ sender: UIButton) {
        datePickerView.removeFromSuperview()
    }
    var toSend = [ProdObj()]
    var addressId = ""
    // MARK: - Functions
    func basketCount() {
        let realm = try? Realm()
        toSend = []
        let result = realm?.objects(ProdObj.self)
        if (result?.count)! > 0 {
            self.bask = Array(result!)
            for i in 0..<bask.count {
                let a = SendProd()
                a.amount = bask[i].amount
                a.id = bask[i].id
//                toSend.append(a)
            }
        }
    }
    func createOrder() -> [[String: AnyObject]]{
        self.toSend = []
        let realm = try? Realm()
        let result = realm?.objects(ProdObj.self)
        self.toSend = Array(result!)
        products.removeAll()
        for item in toSend{

            var product = [String: AnyObject]()
            product["id"] = item.id as AnyObject
            product["amount"] = item.amount as AnyObject
            products.append(product)
        }
        return products
    }
    func checkOutCheck() {
        func next(){
            if  getByDelivery {
                if deliveryDate != "" {
                    self.checkOutReq()
                } else {
                    self.showAlert(title: "Внимание", message: "Укажите врема доставки")
                }
            } else {
                self.checkOutReq()
            }
        }
        if addressId != ""{
            if payByCard {
                if cardsId != "" {
                    next()
                } else {
                    self.showAlert(title: "Внимание", message: "Выберите платежную карту")
                }
            }
            else {
                next()
            }
        } else {
            if getByDelivery {
                self.showAlert(title: "Внимание", message: "Укажите адрес доставки")
            } else {
                self.showAlert(title: "Внимание", message: "Укажите адрес магазина")
            }
        }
    }
    
    func  checkOutReq(){
        let parameters = ["products" : createOrder(),
                          "adress": addressId,
                          "deliver": getByDelivery,
                          "deliverPrice": Int(minDist),
                          "online": payByCard,
        "payCardId": cardsId,
        "deliverDate": deliveryDate] as [String : AnyObject]
        checkOut.isEnabled = false
        checkOutRequest(jsonObject: parameters) { (success) in
            if let names = success.names {
                var show = ""
                for i in 0..<names.count {
                    if i != names.count - 1 {
                        show += "\(names[i]), "
                    } else {
                        show += "\(names[i])"
                    }
                }
                self.checkOut.isEnabled = true
                self.showAlert(title: "Товаров нет на складе", message: show)
            }
            if let a = success.order?.products {
                if a.count > 0 {
                    self.doneAlert()
                }
            }
            if let success = success.success {
                if success {
                    self.doneAlert()
                } else {
                    self.errorAlert()
                }
                
            }
            if let html = success.htmlString {
                self.htmlCode = html
                if let tranzId = success.transactionId {
                    self.tranzId = String(tranzId)
                    self.loadHtmlCode()
                    self.w.frame = CGRect(x: 0, y:64, width: width, height: height - 64)
                }
            }
            self.checkOut.isEnabled = true
        }
    }

    func getMyAddress(){
        getUserAddress { (info) in
            self.myAddress = info
        }
    }
    
  
    
    func getShoptAddressReq() {
        getShopAddresses { (info) in
            self.shopAddress = info
            self.address = info
            if let price = self.address?.deliverPrice?.priceForKm {
                self.deliveryCoeficient = price
            }
            self.addressLabel.text = "Адрес магазина:  "
            self.addressTableView.delegate = self
            self.addressTableView.dataSource = self
            self.addressTableView.reloadData()
        }
    }
    
    func life() {
        w.delegate = self
        getShoptAddressReq()
        timePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        cardTableView.delegate = self
        cardTableView.dataSource = self
        addressTableView.delegate = self
        addressTableView.dataSource = self
    }
    
    func size(){
 
        if getByDelivery {
            newAddressButton.isHidden = false
            pickupButtonView.backgroundColor = UIColor.clear
            deliveryButtonView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.5764705882, blue: 0, alpha: 1)
        } else {
            newAddressButton.isHidden = true
            pickupButtonView.backgroundColor = #colorLiteral(red: 0.4235294118, green: 0.5764705882, blue: 0, alpha: 1)
            deliveryButtonView.backgroundColor = UIColor.clear
        }

        deliveryTimeOutlet.underline()
        newCardButton.applyGradient()
        newAddressButton.applyGradient()
        anotherTime.applyGradient()
        
        checkOut.applyGradient()
        addAddress.applyGradient()
        
        pickupButtonView.circle()
        deliveryButtonView.circle()
        carListView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        addressView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        datePickerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        let xxx = totalProd.formattedWithSeparator
        self.prodSummLabel.text = "Общая сумма: ₸\(xxx)"
        self.summLabel.text = "Итого к оплате: ₸\(xxx)"
    }
    
    func textSets() {
        let now = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "dd-MM HH:mm"
        let dateString = formatter.string(from: now)
        self.timeLabel.text = dateString
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year, let clock = components.hour, let minut = components.minute {
            let myTimeStamp = self.timePicker?.date.timeIntervalSince1970
            self.time = myTimeStamp! // + 86400
            var day2 = day
            let hour = calendar.component(.hour, from: date as Date)
            let curMinut = calendar.component(.minute, from: date as Date)
            let a = (clock * 60 + minut) - (hour * 60 + curMinut)
            if a < 180 && a > 0 {
                day2 = day + 1
                self.time = myTimeStamp! + 86400
//                showAlert(title: "Внимание", message: "Мы не гарантируем доставку в течениe 3 часов")
            }
            else if  a < 0{
                day2 = day + 1
                self.time = myTimeStamp! + 86400
                print("day2 is: \(day2)")
            }
            else {
                day2 = day
            }
            
            self.deliveryDate = String(self.time * 1000)
            print("\(day2) \(month) \(year) \(clock):\(minut)")
            var min = "\(minut)"
            var h = "\(clock)"
            if clock < 10 {
                h = "0\(clock)"
            }
            if minut < 10 {
                min = "\(minut)0"
            }
            var mon = "\(month)"
            if month < 10 {
                mon = "0\(month)"
            }
            var day3 = "\(day2)"
            if day2 < 10 {
                day3 = "0\(day3)"
            }
            self.timeLabel.text = "\(day2)-\(mon)  \(h):\(min)"
            let time = NSAttributedString(string: "Время доставки: \(h):\(min) \(day2).\(mon).\(year)")
            deliveryTimeOutlet.setAttributedTitle(time, for: .normal)
            deliveryTimeOutlet.titleLabel?.text = "Время доставки: \(h):\(min) \(day2).\(mon).\(year)"
            deliveryTimeOutlet.underline()
        }
    }
    var dist = [0]
    var minDist = 0.0
    
    func getRadius() {
        if (shopAddress?.adresses?.count)! > 0 {
            if let shopLat = (shopAddress?.adresses?[0].coordinates?.lat) {
                if let shopLng = (shopAddress?.adresses?[0].coordinates?.lng) {
                    let coordinate0 = CLLocation(latitude: Double(myLat)!, longitude: Double(myLng)!)
                    let coordinate1 = CLLocation(latitude: Double(shopLat)!, longitude: Double(shopLng)!)
                    let distanceInMeters = coordinate0.distance(from: coordinate1)
                    if distanceInMeters > 1000 {
                        deliveryPriceLabel.text = "Сумма доставки: ₸\(1000)"
                        minDist = Double(totalProd + 1000)
                        //                    let x = totalProd.formattedWithSeparator
                        summLabel.text = "Итого к оплате: ₸\(minDist)"
                    } else {
                        self.getAlert()
                    }
                }
            }
        }
 
  
    }
    
    func getDestination(){
        dist = []
        if let n = shopAddress?.adresses?.count {
            if n > 0 {
                getPoint(arr: shopAddress!, index: n - 1)
        }
    }
    }
    
    func getPoint(arr: ShopAdresses, index: Int){
        let origin = "\(myLat),\(myLng)"
        
        if index != -1 {
            let lat = shopAddress!.adresses![index].coordinates!.lat!
            let lng = shopAddress!.adresses![index].coordinates!.lng!
            let destination = "\(lat),\(lng)"
            self.getPoints(origin: origin, destination: destination) { (info) in
             let routes = info.routes!
            if routes.count > 0{
                if (routes[0].legs?.count)! > 0 {
                    if let distance = routes[0].legs?[0].distance?.value {
                        self.dist.append(distance)
                        self.getPoint(arr: self.shopAddress!, index: index - 1)
                    }
                }
            }
        }
        } else {
            if let a = self.dist.min() {
                self.minDist = Double(a * deliveryCoeficient)
                self.minDist = Double(minDist / 1000)
                self.getAlert()
            }
        }
    }
    
    func getAlert(){
        let m = Int(minDist)
        let xxx = m.formattedWithSeparator
        deliveryPriceLabel.text = "Сумма доставки: ₸\(xxx)"
        let a = m + totalProd
        let x = a.formattedWithSeparator
        summLabel.text = "Итого к оплате: ₸\(x)"
        let alert = UIAlertController(title: nil, message: "Сумма доставки: ₸\(xxx)", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func get1000Alert(){
        let message = "Просим обратить внимание на то, что доставка продуктов питания до 1 декабря 2018 года работает в тестовом режиме. В связи с этим, время фактической доставки может значительно отличаться от выбранного Вами"
        
        let alert = UIAlertController(title: "Дорогие покупатели!", message: message, preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        
        let a = UIAlertAction(title: "Я пока не буду заказывать", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        })
        a.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(a)
 
        
        let n = UIAlertAction(title: "Продолжить заказ", style: UIAlertActionStyle.destructive, handler:{ action in
            self.view.addSubview(self.addressView)
        })
        n.setValue(#colorLiteral(red: 0.3734467626, green: 0.6155990958, blue: 0, alpha: 1), forKey: "titleTextColor")
        alert.addAction(n)
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    
    func doneAlert(){

        let alert = UIAlertController(title: nil, message: "Заказ оформлен", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            let realm = try? Realm()
            let result = realm?.objects(ProdObj.self)
            try? realm?.write {
                realm?.delete(result!)
                self.navigationController?.popViewController(animated: true)
            }
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - WebView
    
    func loadHtmlCode() {
        self.view.addSubview(w)
        w.loadHTMLString(htmlCode, baseURL: nil)
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.checktranz()
        }
    }
    func checktranz(){
        checktransaction(transactionId: tranzId) { (succes) in
            if succes.transaction?.payed == true {
                self.w.removeFromSuperview()
                self.doneAlert()
            } else {
                if succes.transaction?.checked == true {
                    self.w.removeFromSuperview()
                    self.errorAlert()
                } else {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        self.view.addSubview(self.w)
                    }
                }
            }
        }
    }
    
    func attentionAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { action in
            self.view.addSubview(self.addressView)
        } ))
        self.present(alert, animated: true)
    }
    
    func errorAlert(){
        let alert = UIAlertController(title: "ОШИБКА!", message: "Оплата не произведена", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: { action in
            
        }
        ))
        self.present(alert, animated: true)
    }
    
    // MARK: - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == addressTableView {
            if address?.adresses?.count != nil {
            return (address?.adresses?.count)!
            }
            return 0
        }
        else {
            if cards?.cards?.count != nil {
             return (cards?.cards?.count)!
            }
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == cardTableView {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! CardListTVC
            let i = indexPath.section
            let c = cards?.cards?[i]
            if let number = c?.cardLastFour {
                cell.cardNumberLabel.text = "**** **** **** \(number)"
            }
            cell.size()
            cell.cellShadow()
        return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! AddressListTVC
            let i = indexPath.section
            if let street = address?.adresses?[i].street {
                if let num = address?.adresses?[i].houseNum {
                    if getByDelivery {
                    cell.addressLabel.text = "Адрес доставки: \(street) \(num)"
                    } else {
                    cell.addressLabel.text = "Адрес магазина: \(street) \(num)"
                    }
                }
            }
            
            cell.size()
            cell.cellShadow()
            return cell
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == addressTableView {
            let street = address!.adresses![indexPath.section].street!
            let num = address!.adresses![indexPath.section].houseNum!
            self.addressId = (address!.adresses![indexPath.section].id!)
            if getByDelivery {
                self.addressLabel.text = "Адрес доставки: \(street) \(num)"
                self.myLat = (address!.adresses![indexPath.section].coordinates?.lat)!
                self.myLng = (address!.adresses![indexPath.section].coordinates?.lng)!
                var active = false
                if let reqActive = self.shopAddress?.deliverPrice?.active {
                    active = reqActive
                }
                if active {
                    self.getDestination()  //to get driver distance of nearest shop
                } else {
                    if let price = self.shopAddress?.deliverPrice?.price {
                        self.minDist = Double(price)
                    }
                    self.getRadius()
                }
            } else {
            self.addressLabel.text = "Адрес магазина: \(street) \(num)"
            }
        }  else {
//            cardLabel.text = "**** **** **** \(cards!.cards![indexPath.section].cardLastFour!)"
            cardsId = "\(cards!.cards![indexPath.section].id!)"
        }
        addressView.removeFromSuperview()
        carListView.removeFromSuperview()
    }

}

class CardListTVC: UITableViewCell {
    @IBOutlet var cardNumberLabel: UILabel!
    
    func size() {
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
}

class AddressListTVC: UITableViewCell {
    func size() {
        self.layer.borderWidth = 0.4
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    @IBOutlet var addressLabel: UILabel!
}


class SendProd : NSObject {
    var id = String()
    var amount = Int()
    
}
