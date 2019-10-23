//
//  extentions.swift
//  AKMaskField
//
//  Created by Dakanov Sultan on 09.08.2018.
//

import UIKit
import RealmSwift

extension UIViewController {
    func prodCountForBadge(){
        if let tabItems = self.tabBarController?.tabBar.items as NSArray!
        {
            var bask = [ProdObj()]
            let tabItem = tabItems[3] as! UITabBarItem
            let realm = try? Realm()
            let result = realm?.objects(ProdObj.self)
            if (result?.count)! > 0 {
                bask = Array(result!)
                let count = bask.count
                if count > 0 {
                    tabItem.badgeValue = "\(count)"
                } else {
                    tabItem.badgeValue = nil
                }
            } else {
                tabItem.badgeValue = nil
            }
        }
    }
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func demo(){
        if UserDefaults.standard.string(forKey: "token") == nil{
            exitAlert()
            return
        }
    }
    func exitAlert(){
        let alert = UIAlertController(title: "Внимание", message: "Вы не авторизованы", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (UIAlertAction) in
            self.logout()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func logout(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "Start")
        present(vc, animated: true) {
            self.tabBarController?.selectedIndex = 0
        }
    }
    func exitReqAlert(){
        let alert = UIAlertController(title: "Выйти?", message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default, handler: { (UIAlertAction) in
            self.tabBarController?.selectedIndex = 0
            self.logout()
        }))
        alert.addAction(UIAlertAction(title: "Нет", style: .default, handler: { (UIAlertAction) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    func convertDateFormatter(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        dateFormatter.locale = Locale(identifier: "your_loc_id")
        let convertedDate = dateFormatter.date(from: date)
        
        guard dateFormatter.date(from: date) != nil else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "yyyy MMM HH:mm EEEE"///this is what you want to convert format
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone!
        let timeStamp = dateFormatter.string(from: convertedDate!)
        
        return timeStamp
    }
    func getTimestamp(date: String) -> TimeInterval{
        
        let string = date
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd.MM.yyyy" ; //"dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale --> but no need here
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        let timestamp = date.timeIntervalSince1970
        return timestamp
    }
    func DateFormat(date: String) -> String{
        
        let string = date
        let dateFormatter = DateFormatter()
        let tempLocale = dateFormatter.locale // save locale temporarily
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: string)!
        dateFormatter.dateFormat = "dd.MM.yyyy" ; //"dd-MM-yyyy HH:mm:ss"
        dateFormatter.locale = tempLocale // reset the locale --> but no need here
        let dateString = dateFormatter.string(from: date)
        print("EXACT_DATE : \(dateString)")
        return dateString
    }
}

extension String {
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }   
}

extension UIView {
    func startLoading(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        
        self.addSubview(blurEffectView)
    }
    
    func stopLoading(){
        self.subviews.flatMap {  $0 as? UIVisualEffectView }.forEach {
            $0.removeFromSuperview()
        }
    }
    func shadow() {
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
    }
    func shadowOff() {
        layer.shadowColor = UIColor.clear.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 2
    }
    func cellShadow(){
        layer.borderColor = UIColor.lightGray.cgColor
        let shadowPath2 = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
        layer.shadowOpacity = 0.3
        layer.shadowPath = shadowPath2.cgPath
    }
    func applyGradient(){
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [#colorLiteral(red: 0.662745098, green: 0.737254902, blue: 0.2745098039, alpha: 1).cgColor, #colorLiteral(red: 0.2509803922, green: 0.3058823529, blue: 0.07843137255, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = 10
        layer.cornerRadius = 10
        layer.borderWidth = 1
        self.layer.insertSublayer(gradient, at: 0)
    }
    func blackGrad() {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor, #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        gradient.cornerRadius = 10
        layer.cornerRadius = 10
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func circle(){
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 0.4
    }
}
extension UILabel {
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedStringKey.underlineStyle,
                                          value: NSUnderlineStyle.styleSingle.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}

extension UIButton {
    func underline() {
        let attributedString = NSMutableAttributedString(string: (self.titleLabel?.text!)!)
        attributedString.addAttribute(NSAttributedStringKey.underlineStyle,
                                      value: NSUnderlineStyle.styleSingle.rawValue,
                                      range: NSRange(location: 0, length: (self.titleLabel?.text!.count)!))
        self.setAttributedTitle(attributedString, for: .normal)
    }
}
extension BinaryInteger {
    var formattedWithSeparator: String {
        return Formatter.withSeparator.string(for: self) ?? ""
    }
}
extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

