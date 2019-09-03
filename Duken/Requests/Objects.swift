//
//  Objects.swift
//  Duken
//
//  Created by Dakanov Sultan on 16.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import ObjectMapper
import AlamofireObjectMapper
import RealmSwift



class Contacts : NSObject, NSCoding, Mappable{
    
    var contacts : Contact?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Contacts()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        contacts <- map["contacts"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        contacts = aDecoder.decodeObject(forKey: "contacts") as? Contact
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if contacts != nil{
            aCoder.encode(contacts, forKey: "contacts")
        }
        
    }
    
}


class Contact : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var createdAt : String?
    var emails : [String]?
    var phones : [String]?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Contact()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        createdAt <- map["createdAt"]
        emails <- map["emails"]
        phones <- map["phones"]
        updatedAt <- map["updatedAt"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        emails = aDecoder.decodeObject(forKey: "emails") as? [String]
        phones = aDecoder.decodeObject(forKey: "phones") as? [String]
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if emails != nil{
            aCoder.encode(emails, forKey: "emails")
        }
        if phones != nil{
            aCoder.encode(phones, forKey: "phones")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        
    }
    
}

class Cards : NSObject, NSCoding, Mappable{
    
    var cards : [Card]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Cards()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        cards <- map["cards"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cards = aDecoder.decodeObject(forKey: "cards") as? [Card]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cards != nil{
            aCoder.encode(cards, forKey: "cards")
        }
        
    }
    
}
class OplataObj : Mappable{
    
    var success : Bool?
    var error : String?
    var secure : Bool?
    var msg : String?
    var htmlString : String?
    var transactionId : Int?
    
    required init?(map: Map){}
    
    func mapping(map: Map)
    {
        success <- map["Success"]
        error <- map["error"]
        secure <- map["secure"]
        msg <- map["msg"]
        htmlString <- map["htmlString"]
        transactionId <- map["TransactionId"]
    }
    
}

class CheckTranz1 : Mappable{
    
    var success : String?
    var checked : String?
    
    
    required init?(map: Map){}
    func mapping(map: Map)
    {
        success <- map["success"]
        checked <- map["checked"]
    }
    
}


class CheckTranz :  Mappable{
    
    var transaction : Transaction?
    
    required init?(map: Map){}
    func mapping(map: Map)
    {
        transaction <- map["transaction"]
    }
    
}


class Transaction :  Mappable{
    
    var transactionId : String?
    var v : Int?
    var id : String?
    var checked : Bool?
    var createdAt : String?
    var payed : Bool?
    var refund : Bool?
    var refundRes : Bool?
    var updatedAt : String?
    
    

    required init?(map: Map){}
    
    
    func mapping(map: Map)
    {
        transactionId <- map["TransactionId"]
        v <- map["__v"]
        id <- map["_id"]
        checked <- map["checked"]
        createdAt <- map["createdAt"]
        payed <- map["payed"]
        refund <- map["refund"]
        refundRes <- map["refundRes"]
        updatedAt <- map["updatedAt"]
        
    }
}

class Card : NSObject, NSCoding, Mappable{
    
    var cardLastFour : Int?
    var cardType : String?
    var token : String?
    var v : Int?
    var id : String?
    var createdAt : String?
    var status : String?
    var updatedAt : String?
    var user : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Card()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        cardLastFour <- map["CardLastFour"]
        cardType <- map["CardType"]
        token <- map["Token"]
        v <- map["__v"]
        id <- map["_id"]
        createdAt <- map["createdAt"]
        status <- map["status"]
        updatedAt <- map["updatedAt"]
        user <- map["user"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cardLastFour = aDecoder.decodeObject(forKey: "CardLastFour") as? Int
        cardType = aDecoder.decodeObject(forKey: "CardType") as? String
        token = aDecoder.decodeObject(forKey: "Token") as? String
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        user = aDecoder.decodeObject(forKey: "user") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cardLastFour != nil{
            aCoder.encode(cardLastFour, forKey: "CardLastFour")
        }
        if cardType != nil{
            aCoder.encode(cardType, forKey: "CardType")
        }
        if token != nil{
            aCoder.encode(token, forKey: "Token")
        }
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}

class Orders :  Mappable{
    
    var order : Order?
    var err: String?
    var names : [String]?
    var success : Bool?
    var htmlString : String?
    var transactionId : Int?
    

    required init?(map: Map){}
    
    
    func mapping(map: Map)
    {
        order <- map["order"]
        err <- map["err"]
        names <- map["names"]
        htmlString <- map["htmlString"]
        success <- map["Success"]
        transactionId <- map["TransactionId"]
        
    }
    
   
    
}



class Order : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var adminComment : String?
    var adress : String?
    var amount : Int?
    var createdAt : String?
    var dateOf : String?
    var deliver : Bool?
    var deliverPrice : Int?
    var done : Bool?
    var online : Bool?
    var products : [Product]?
    var summ : Int?
    var updatedAt : String?
    var user : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Order()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        adminComment <- map["adminComment"]
        adress <- map["adress"]
        amount <- map["amount"]
        createdAt <- map["createdAt"]
        dateOf <- map["dateOf"]
        deliver <- map["deliver"]
        deliverPrice <- map["deliverPrice"]
        done <- map["done"]
        online <- map["online"]
        products <- map["products"]
        summ <- map["summ"]
        updatedAt <- map["updatedAt"]
        user <- map["user"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        adminComment = aDecoder.decodeObject(forKey: "adminComment") as? String
        adress = aDecoder.decodeObject(forKey: "adress") as? String
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        dateOf = aDecoder.decodeObject(forKey: "dateOf") as? String
        deliver = aDecoder.decodeObject(forKey: "deliver") as? Bool
        deliverPrice = aDecoder.decodeObject(forKey: "deliverPrice") as? Int
        done = aDecoder.decodeObject(forKey: "done") as? Bool
        online = aDecoder.decodeObject(forKey: "online") as? Bool
        products = aDecoder.decodeObject(forKey: "products") as? [Product]
        summ = aDecoder.decodeObject(forKey: "summ") as? Int
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        user = aDecoder.decodeObject(forKey: "user") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if adminComment != nil{
            aCoder.encode(adminComment, forKey: "adminComment")
        }
        if adress != nil{
            aCoder.encode(adress, forKey: "adress")
        }
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if dateOf != nil{
            aCoder.encode(dateOf, forKey: "dateOf")
        }
        if deliver != nil{
            aCoder.encode(deliver, forKey: "deliver")
        }
        if deliverPrice != nil{
            aCoder.encode(deliverPrice, forKey: "deliverPrice")
        }
        if done != nil{
            aCoder.encode(done, forKey: "done")
        }
        if online != nil{
            aCoder.encode(online, forKey: "online")
        }
        if products != nil{
            aCoder.encode(products, forKey: "products")
        }
        if summ != nil{
            aCoder.encode(summ, forKey: "summ")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}

class ProductHistoryRootClass : NSObject, NSCoding, Mappable{
    
    var histories : [ProductHistoryHistory]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ProductHistoryRootClass()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        histories <- map["histories"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        histories = aDecoder.decodeObject(forKey: "histories") as? [ProductHistoryHistory]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if histories != nil{
            aCoder.encode(histories, forKey: "histories")
        }
        
    }
    
}



class ProductHistoryHistory : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var adminComment : String?
    var adress : String?
    var amount : Int?
    var createdAt : String?
    var dateOf : String?
    var deliver : Bool?
    var deliverPrice : Int?
    var online : Bool?
    var products : [ProductHistoryProduct]?
    var summ : Int?
    var updatedAt : String?
    var user : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ProductHistoryHistory()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        adminComment <- map["adminComment"]
        adress <- map["adress"]
        amount <- map["amount"]
        createdAt <- map["createdAt"]
        dateOf <- map["dateOf"]
        deliver <- map["deliver"]
        deliverPrice <- map["deliverPrice"]
        online <- map["online"]
        products <- map["products"]
        summ <- map["summ"]
        updatedAt <- map["updatedAt"]
        user <- map["user"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        adminComment = aDecoder.decodeObject(forKey: "adminComment") as? String
        adress = aDecoder.decodeObject(forKey: "adress") as? String
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        dateOf = aDecoder.decodeObject(forKey: "dateOf") as? String
        deliver = aDecoder.decodeObject(forKey: "deliver") as? Bool
        deliverPrice = aDecoder.decodeObject(forKey: "deliverPrice") as? Int
        online = aDecoder.decodeObject(forKey: "online") as? Bool
        products = aDecoder.decodeObject(forKey: "products") as? [ProductHistoryProduct]
        summ = aDecoder.decodeObject(forKey: "summ") as? Int
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        user = aDecoder.decodeObject(forKey: "user") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if adminComment != nil{
            aCoder.encode(adminComment, forKey: "adminComment")
        }
        if adress != nil{
            aCoder.encode(adress, forKey: "adress")
        }
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if dateOf != nil{
            aCoder.encode(dateOf, forKey: "dateOf")
        }
        if deliver != nil{
            aCoder.encode(deliver, forKey: "deliver")
        }
        if deliverPrice != nil{
            aCoder.encode(deliverPrice, forKey: "deliverPrice")
        }
        if online != nil{
            aCoder.encode(online, forKey: "online")
        }
        if products != nil{
            aCoder.encode(products, forKey: "products")
        }
        if summ != nil{
            aCoder.encode(summ, forKey: "summ")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}


class ProductHistoryProduct : NSObject, NSCoding, Mappable{
    
    var id : String?
    var amount : Int?
    var idd : HistProd?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return ProductHistoryProduct()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        amount <- map["amount"]
        idd <- map["id"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "_id") as? String
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        idd = aDecoder.decodeObject(forKey: "id") as? HistProd
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if idd != nil{
            aCoder.encode(idd, forKey: "id")
        }
        
    }
    
}

class HistProd : NSObject, NSCoding, Mappable{
    
    var id : String?
    var category : String?
    var descriptionField : String?
    var img : String?
    var name : String?
    var podCategory : String?
    var price : String?
    var sizeOfPackage : Int?
    var volume : Int?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return HistProd()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        category <- map["category"]
        descriptionField <- map["description"]
        img <- map["img"]
        name <- map["name"]
        podCategory <- map["podCategory"]
        price <- map["price"]
        sizeOfPackage <- map["sizeOfPackage"]
        volume <- map["volume"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "_id") as? String
        category = aDecoder.decodeObject(forKey: "category") as? String
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        img = aDecoder.decodeObject(forKey: "img") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        podCategory = aDecoder.decodeObject(forKey: "podCategory") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        sizeOfPackage = aDecoder.decodeObject(forKey: "sizeOfPackage") as? Int
        volume = aDecoder.decodeObject(forKey: "volume") as? Int
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if podCategory != nil{
            aCoder.encode(podCategory, forKey: "podCategory")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if sizeOfPackage != nil{
            aCoder.encode(sizeOfPackage, forKey: "sizeOfPackage")
        }
        if volume != nil{
            aCoder.encode(volume, forKey: "volume")
        }
        
    }
    
}

class MyAddress : NSObject, NSCoding, Mappable{
    
    var adresses : [Adresse]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return MyAddress()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        adresses <- map["adresses"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        adresses = aDecoder.decodeObject(forKey: "adresses") as? [Adresse]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if adresses != nil{
            aCoder.encode(adresses, forKey: "adresses")
        }
        
    }
    
}



class Products : NSObject, NSCoding, Mappable{
    
    var products : [Product]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Products()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        products <- map["products"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        products = aDecoder.decodeObject(forKey: "products") as? [Product]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if products != nil{
            aCoder.encode(products, forKey: "products")
        }
        
    }
    
}

class SingleProduct : NSObject, NSCoding, Mappable{
    
    var product : Product?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return SingleProduct()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        product <- map["product"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        product = aDecoder.decodeObject(forKey: "product") as? Product
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if product != nil{
            aCoder.encode(product, forKey: "product")
        }
        
    }
    
}

class Product : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var amount : Int?
    var article : String?
    var cartImg : String?
    var category : String?
    var createdAt : String?
    var dateOfEditing : String?
    var desImg : [String]?
    var descriptionField : String?
    var img : String?
    var keyWords : [String]?
    var name : String?
    var podCategory : String?
    var price : String?
    var shortDescription : String?
    var sizeOfPackage : Int?
    var sortNumber : Int?
    var status : String?
    var top : Bool?
    var updatedAt : String?
    var volume : Int?
    var idd : OrdersProd?
    
    class func newInstance(map: Map) -> Mappable?{
        return Product()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        amount <- map["amount"]
        article <- map["article"]
        cartImg <- map["cartImg"]
        category <- map["category"]
        createdAt <- map["createdAt"]
        dateOfEditing <- map["dateOfEditing"]
        desImg <- map["desImg"]
        descriptionField <- map["description"]
        img <- map["img"]
        keyWords <- map["keyWords"]
        name <- map["name"]
        podCategory <- map["podCategory"]
        price <- map["price"]
        shortDescription <- map["shortDescription"]
        sizeOfPackage <- map["sizeOfPackage"]
        sortNumber <- map["sortNumber"]
        status <- map["status"]
        top <- map["top"]
        updatedAt <- map["updatedAt"]
        volume <- map["volume"]
        idd <- map["id"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        article = aDecoder.decodeObject(forKey: "article") as? String
        cartImg = aDecoder.decodeObject(forKey: "cartImg") as? String
        category = aDecoder.decodeObject(forKey: "category") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        dateOfEditing = aDecoder.decodeObject(forKey: "dateOfEditing") as? String
        desImg = aDecoder.decodeObject(forKey: "desImg") as? [String]
        descriptionField = aDecoder.decodeObject(forKey: "description") as? String
        img = aDecoder.decodeObject(forKey: "img") as? String
        keyWords = aDecoder.decodeObject(forKey: "keyWords") as? [String]
        name = aDecoder.decodeObject(forKey: "name") as? String
        podCategory = aDecoder.decodeObject(forKey: "podCategory") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        shortDescription = aDecoder.decodeObject(forKey: "shortDescription") as? String
        sizeOfPackage = aDecoder.decodeObject(forKey: "sizeOfPackage") as? Int
        sortNumber = aDecoder.decodeObject(forKey: "sortNumber") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? String
        top = aDecoder.decodeObject(forKey: "top") as? Bool
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        volume = aDecoder.decodeObject(forKey: "volume") as? Int
        idd = aDecoder.decodeObject(forKey: "id") as? OrdersProd
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if idd != nil{
            aCoder.encode(id, forKey: "id")
        }
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if article != nil{
            aCoder.encode(article, forKey: "article")
        }
        if cartImg != nil{
            aCoder.encode(cartImg, forKey: "cartImg")
        }
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if dateOfEditing != nil{
            aCoder.encode(dateOfEditing, forKey: "dateOfEditing")
        }
        if desImg != nil{
            aCoder.encode(desImg, forKey: "desImg")
        }
        if descriptionField != nil{
            aCoder.encode(descriptionField, forKey: "description")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if keyWords != nil{
            aCoder.encode(keyWords, forKey: "keyWords")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if podCategory != nil{
            aCoder.encode(podCategory, forKey: "podCategory")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        if shortDescription != nil{
            aCoder.encode(shortDescription, forKey: "shortDescription")
        }
        if sizeOfPackage != nil{
            aCoder.encode(sizeOfPackage, forKey: "sizeOfPackage")
        }
        if sortNumber != nil{
            aCoder.encode(sortNumber, forKey: "sortNumber")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if top != nil{
            aCoder.encode(top, forKey: "top")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if volume != nil{
            aCoder.encode(volume, forKey: "volume")
        }
        
    }
    
}


class OrdersProd : NSObject, NSCoding, Mappable{
    
    var id : String?
    var category : String?
    var img : String?
    var measure : Measure?
    var name : String?
    var podCategory : String?
    var price : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return OrdersProd()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        id <- map["_id"]
        category <- map["category"]
        img <- map["img"]
        measure <- map["measure"]
        name <- map["name"]
        podCategory <- map["podCategory"]
        price <- map["price"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "_id") as? String
        category = aDecoder.decodeObject(forKey: "category") as? String
        img = aDecoder.decodeObject(forKey: "img") as? String
        measure = aDecoder.decodeObject(forKey: "measure") as? Measure
        name = aDecoder.decodeObject(forKey: "name") as? String
        podCategory = aDecoder.decodeObject(forKey: "podCategory") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if category != nil{
            aCoder.encode(category, forKey: "category")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if measure != nil{
            aCoder.encode(measure, forKey: "measure")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if podCategory != nil{
            aCoder.encode(podCategory, forKey: "podCategory")
        }
        if price != nil{
            aCoder.encode(price, forKey: "price")
        }
        
    }
    
}

class Measure : NSObject, NSCoding, Mappable{
    
    var amount : Int?
    var scale : String?
    var unit : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Measure()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        amount <- map["amount"]
        scale <- map["scale"]
        unit <- map["unit"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        amount = aDecoder.decodeObject(forKey: "amount") as? Int
        scale = aDecoder.decodeObject(forKey: "scale") as? String
        unit = aDecoder.decodeObject(forKey: "unit") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if amount != nil{
            aCoder.encode(amount, forKey: "amount")
        }
        if scale != nil{
            aCoder.encode(scale, forKey: "scale")
        }
        if unit != nil{
            aCoder.encode(unit, forKey: "unit")
        }
        
    }
    
}
class Profile : NSObject, NSCoding, Mappable{
    
    var user : User?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Profile()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        user <- map["user"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        user = aDecoder.decodeObject(forKey: "user") as? User
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if user != nil{
            aCoder.encode(user, forKey: "user")
        }
        
    }
    
}


class User : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var createdAt : String?
    var name : String?
    var phone : String?
    var status : String?
    var type : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return User()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        createdAt <- map["createdAt"]
        name <- map["name"]
        phone <- map["phone"]
        status <- map["status"]
        type <- map["type"]
        updatedAt <- map["updatedAt"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        type = aDecoder.decodeObject(forKey: "type") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if type != nil{
            aCoder.encode(type, forKey: "type")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        
    }
    
}

class Categories : NSObject, NSCoding, Mappable{
    
    var categories : [Category]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Categories()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        categories <- map["categories"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        categories = aDecoder.decodeObject(forKey: "categories") as? [Category]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if categories != nil{
            aCoder.encode(categories, forKey: "categories")
        }
        
    }
    
}

class Category : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var createdAt : String?
    var name : String?
    var sortnum : Float?
    var status : String?
    var updatedAt : String?
    var image : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Category()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        createdAt <- map["createdAt"]
        name <- map["name"]
        sortnum <- map["sortnum"]
        status <- map["status"]
        updatedAt <- map["updatedAt"]
        image <- map["img"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        sortnum = aDecoder.decodeObject(forKey: "sortnum") as? Float
        status = aDecoder.decodeObject(forKey: "status") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        image = aDecoder.decodeObject(forKey: "img") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if sortnum != nil{
            aCoder.encode(sortnum, forKey: "sortnum")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        if image != nil{
            aCoder.encode(updatedAt, forKey: "img")
        }
    }
    
}

class Banners : NSObject, NSCoding, Mappable{
    
    var banners : [Banner]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Banners()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        banners <- map["banners"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        banners = aDecoder.decodeObject(forKey: "banners") as? [Banner]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if banners != nil{
            aCoder.encode(banners, forKey: "banners")
        }
        
    }
    
}

class Banner : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var createdAt : String?
    var img : String?
    var keyWords : [String]?
    var name : String?
    var status : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Banner()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        createdAt <- map["createdAt"]
        img <- map["img"]
        keyWords <- map["keyWords"]
        name <- map["name"]
        status <- map["status"]
        updatedAt <- map["updatedAt"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        img = aDecoder.decodeObject(forKey: "img") as? String
        keyWords = aDecoder.decodeObject(forKey: "keyWords") as? [String]
        name = aDecoder.decodeObject(forKey: "name") as? String
        status = aDecoder.decodeObject(forKey: "status") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if img != nil{
            aCoder.encode(img, forKey: "img")
        }
        if keyWords != nil{
            aCoder.encode(keyWords, forKey: "keyWords")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        
    }
    
}


class ShopAdresses : NSObject, NSCoding, Mappable{
    
    var adresses : [Adresse]?
    var deliverPrice : DeliverPrice?
    
    class func newInstance(map: Map) -> Mappable?{
        return ShopAdresses()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        adresses <- map["adresses"]
        deliverPrice <- map["deliverPrice"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        adresses = aDecoder.decodeObject(forKey: "adresses") as? [Adresse]
        deliverPrice = aDecoder.decodeObject(forKey: "deliverPrice") as? DeliverPrice
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if adresses != nil{
            aCoder.encode(adresses, forKey: "adresses")
        }
        if deliverPrice != nil{
            aCoder.encode(adresses, forKey: "deliverPrice")
        }
        
    }
    
}

class Adresse : NSObject, NSCoding, Mappable{
    
    var v : Int?
    var id : String?
    var city : String?
    var coordinates : Coordinate?
    var createdAt : String?
    var district : String?
    var flatNum : AnyObject?
    var houseNum : Int?
    var status : String?
    var street : String?
    var updatedAt : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Adresse()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        v <- map["__v"]
        id <- map["_id"]
        city <- map["city"]
        coordinates <- map["coordinates"]
        createdAt <- map["createdAt"]
        district <- map["district"]
        flatNum <- map["flatNum"]
        houseNum <- map["houseNum"]
        status <- map["status"]
        street <- map["street"]
        updatedAt <- map["updatedAt"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        v = aDecoder.decodeObject(forKey: "__v") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        city = aDecoder.decodeObject(forKey: "city") as? String
        coordinates = aDecoder.decodeObject(forKey: "coordinates") as? Coordinate
        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? String
        district = aDecoder.decodeObject(forKey: "district") as? String
        flatNum = aDecoder.decodeObject(forKey: "flatNum") as? AnyObject
        houseNum = aDecoder.decodeObject(forKey: "houseNum") as? Int
        status = aDecoder.decodeObject(forKey: "status") as? String
        street = aDecoder.decodeObject(forKey: "street") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updatedAt") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if v != nil{
            aCoder.encode(v, forKey: "__v")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if city != nil{
            aCoder.encode(city, forKey: "city")
        }
        if coordinates != nil{
            aCoder.encode(coordinates, forKey: "coordinates")
        }
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "createdAt")
        }
        if district != nil{
            aCoder.encode(district, forKey: "district")
        }
        if flatNum != nil{
            aCoder.encode(flatNum, forKey: "flatNum")
        }
        if houseNum != nil{
            aCoder.encode(houseNum, forKey: "houseNum")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if street != nil{
            aCoder.encode(street, forKey: "street")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updatedAt")
        }
        
    }
    
}



class Coordinate : NSObject, NSCoding, Mappable{
    
    var lat : String?
    var lng : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Coordinate()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        lat <- map["lat"]
        lng <- map["lng"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        lat = aDecoder.decodeObject(forKey: "lat") as? String
        lng = aDecoder.decodeObject(forKey: "lng") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }
        
    }
    
}


class DeliverPrice : NSObject, NSCoding, Mappable{
    
    var price : Int?
    var priceForKm : Int?
    var id : String?
    var active : Bool?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return DeliverPrice()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        price <- map["Price"]
        priceForKm <- map["PriceForKm"]
        id <- map["_id"]
        active <- map["active"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        price = aDecoder.decodeObject(forKey: "Price") as? Int
        priceForKm = aDecoder.decodeObject(forKey: "PriceForKm") as? Int
        id = aDecoder.decodeObject(forKey: "_id") as? String
        active = aDecoder.decodeObject(forKey: "active") as? Bool
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if price != nil{
            aCoder.encode(price, forKey: "Price")
        }
        if priceForKm != nil{
            aCoder.encode(priceForKm, forKey: "PriceForKm")
        }
        if id != nil{
            aCoder.encode(id, forKey: "_id")
        }
        if active != nil{
            aCoder.encode(active, forKey: "active")
        }
        
    }
    
}

class RegisterData : NSObject, NSCoding, Mappable{
    
    var message : String?
    var success : Bool?
    var token : String?
    var error : String?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return RegisterData()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        message <- map["message"]
        success <- map["success"]
        token <- map["token"]
        error <- map["error"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        message = aDecoder.decodeObject(forKey: "message") as? String
        success = aDecoder.decodeObject(forKey: "success") as? Bool
        token = aDecoder.decodeObject(forKey: "token") as? String
        error = aDecoder.decodeObject(forKey: "error") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if success != nil{
            aCoder.encode(success, forKey: "success")
        }
        if token != nil{
            aCoder.encode(token, forKey: "token")
        }
        if error != nil{
            aCoder.encode(error, forKey: "error")
        }
        
    }
    
}

class Address : NSObject, NSCoding, Mappable{
    
    var results : [Result]?
    var status : String?
    var error: String?
    
    class func newInstance(map: Map) -> Mappable?{
        return Address()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        results <- map["results"]
        status <- map["status"]
        error <- map["error_message"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        results = aDecoder.decodeObject(forKey: "results") as? [Result]
        status = aDecoder.decodeObject(forKey: "status") as? String
        error = aDecoder.decodeObject(forKey: "error_message") as? String
    }
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if results != nil{
            aCoder.encode(results, forKey: "results")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if error != nil{
            aCoder.encode(status, forKey: "error_message")
        }
        
    }
}


class Result : NSObject, NSCoding, Mappable{
    
    var addressComponents : [AddressComponent]?
    var formattedAddress : String?
    var geometry : Geometry?
    var placeId : String?
    var types : [String]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Result()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        addressComponents <- map["address_components"]
        formattedAddress <- map["formatted_address"]
        geometry <- map["geometry"]
        placeId <- map["place_id"]
        types <- map["types"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        addressComponents = aDecoder.decodeObject(forKey: "address_components") as? [AddressComponent]
        formattedAddress = aDecoder.decodeObject(forKey: "formatted_address") as? String
        geometry = aDecoder.decodeObject(forKey: "geometry") as? Geometry
        placeId = aDecoder.decodeObject(forKey: "place_id") as? String
        types = aDecoder.decodeObject(forKey: "types") as? [String]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if addressComponents != nil{
            aCoder.encode(addressComponents, forKey: "address_components")
        }
        if formattedAddress != nil{
            aCoder.encode(formattedAddress, forKey: "formatted_address")
        }
        if geometry != nil{
            aCoder.encode(geometry, forKey: "geometry")
        }
        if placeId != nil{
            aCoder.encode(placeId, forKey: "place_id")
        }
        if types != nil{
            aCoder.encode(types, forKey: "types")
        }
        
    }
    
}

class Geometry : NSObject, NSCoding, Mappable{
    
    var bounds : Bound1?
    var location : Northeast?
    var locationType : String?
    var viewport : Bound1?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Geometry()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        bounds <- map["bounds"]
        location <- map["location"]
        locationType <- map["location_type"]
        viewport <- map["viewport"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        bounds = aDecoder.decodeObject(forKey: "bounds") as? Bound1
        location = aDecoder.decodeObject(forKey: "location") as? Northeast
        locationType = aDecoder.decodeObject(forKey: "location_type") as? String
        viewport = aDecoder.decodeObject(forKey: "viewport") as? Bound1
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if bounds != nil{
            aCoder.encode(bounds, forKey: "bounds")
        }
        if location != nil{
            aCoder.encode(location, forKey: "location")
        }
        if locationType != nil{
            aCoder.encode(locationType, forKey: "location_type")
        }
        if viewport != nil{
            aCoder.encode(viewport, forKey: "viewport")
        }
        
    }
    
}

class Bound1 : NSObject, NSCoding, Mappable{
    
    var northeast : Northeast?
    var southwest : Northeast?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Bound1()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        northeast <- map["northeast"]
        southwest <- map["southwest"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        northeast = aDecoder.decodeObject(forKey: "northeast") as? Northeast
        southwest = aDecoder.decodeObject(forKey: "southwest") as? Northeast
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if northeast != nil{
            aCoder.encode(northeast, forKey: "northeast")
        }
        if southwest != nil{
            aCoder.encode(southwest, forKey: "southwest")
        }
        
    }
    
}


class Northeast : NSObject, NSCoding, Mappable{
    
    var lat : Float?
    var lng : Float?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return Northeast()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        lat <- map["lat"]
        lng <- map["lng"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        lat = aDecoder.decodeObject(forKey: "lat") as? Float
        lng = aDecoder.decodeObject(forKey: "lng") as? Float
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if lat != nil{
            aCoder.encode(lat, forKey: "lat")
        }
        if lng != nil{
            aCoder.encode(lng, forKey: "lng")
        }
        
    }
    
}


class AddressComponent : NSObject, NSCoding, Mappable{
    
    var longName : String?
    var shortName : String?
    var types : [String]?
    
    
    class func newInstance(map: Map) -> Mappable?{
        return AddressComponent()
    }
    required init?(map: Map){}
    private override init(){}
    
    func mapping(map: Map)
    {
        longName <- map["long_name"]
        shortName <- map["short_name"]
        types <- map["types"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        longName = aDecoder.decodeObject(forKey: "long_name") as? String
        shortName = aDecoder.decodeObject(forKey: "short_name") as? String
        types = aDecoder.decodeObject(forKey: "types") as? [String]
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if longName != nil{
            aCoder.encode(longName, forKey: "long_name")
        }
        if shortName != nil{
            aCoder.encode(shortName, forKey: "short_name")
        }
        if types != nil{
            aCoder.encode(types, forKey: "types")
        }
        
    }
    
}

class Basket: NSObject,NSCoding {
    var id = String()
    var count = Int()
   
    init(id: String, count: Int){
        self.id = id
        self.count = count
    }
    required init(coder decoder: NSCoder){
        self.id = (decoder.decodeObject(forKey: "id") as? String)!
        self.count = (decoder.decodeObject(forKey: "count") as? Int)!
    }
    func encode(with coder: NSCoder){
        coder.encode(id, forKey: "id")
        coder.encode(count, forKey: "count")
    }
    
}
class Bask: Object {
    @objc dynamic var id = String()
    @objc dynamic var count = Int()
}

class ProdObj: Object {
    @objc dynamic var id = String()
    @objc dynamic var amount = Int()
}
