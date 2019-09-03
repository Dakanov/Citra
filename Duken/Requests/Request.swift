//
//  Request.swift
//  Duken
//
//  Created by Dakanov Sultan on 16.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper
import ObjectMapper


//let url = "http://192.168.88.39:4443/"
let url = "http://194.4.58.36:4443/"
//let url = "http://92.63.99.164:4443/"

extension UIViewController{
    
    
    func getAddressInfo( lat : String, long: String, completionHandler: @escaping ( _ params: Address) -> ()) {
        let url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(long)&sensor=true"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Address>) in
            if let info = response.result.value{
                completionHandler(info)
            }
        }
    }
    
    func signUpReq(parameters: [String: AnyObject], completionHandler: @escaping (_ params: RegisterData) -> ()) {
        Alamofire.request("\(url)api/users/verify", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RegisterData>) in
                print("RESPONSE", response)
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value?.error {
                      print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
        }
    }
    func cardDelete(parameters: [String: AnyObject], completionHandler: @escaping (_ params: RegisterData) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/paycards/delete", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<RegisterData>) in
            print("RESPONSE", response)
            if (response.response?.statusCode)! < 202{
                if let info = response.result.value {
                    completionHandler(info)
                }
            }else{
                if let msg = response.result.value?.error {
                    print(msg)
                } else {
                    print("Произошла какая-то ошибка")
                }
            }
        }
    }
    func addressDelete(parameters: [String: AnyObject], completionHandler: @escaping (_ params: RegisterData) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/adresses/delete", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<RegisterData>) in
            print("RESPONSE", response)
            if (response.response?.statusCode)! < 202{
                if let info = response.result.value {
                    completionHandler(info)
                }
            }else{
                if let msg = response.result.value?.error {
                    print(msg)
                } else {
                    print("Произошла какая-то ошибка")
                }
            }
        }
    }
    

    func loginReq(login : String, parameters: [String: AnyObject], completionHandler: @escaping (_ params: RegisterData) -> ()) {
        Alamofire.request("\(url)api/\(login)", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RegisterData>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let msg = response.result.value?.error {
                        print(msg)
                    }
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value?.error {
                        print(msg)
                        self.showAlert(title: "Внимание", message: msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
     
        }
    }
    
    func checkPhone(parameters: [String: AnyObject], completionHandler: @escaping (_ params: RegisterData) -> ()) {
        Alamofire.request("\(url)api/users/checkphone", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<RegisterData>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202 {
                    if let msg = response.result.value?.error {
                        print(msg)
                    }
                    if let info = response.result.value {
                        print(info)
                        completionHandler(info)
                    }
                }
                else if response.response?.statusCode == 404 {
                    print(response.result.value?.error)
                    self.showAlert(title: "Внимание", message: "Номер не зарегистрирован")
                }
                else {
                    if let msg = response.result.value?.error {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
            
        }
    }
    
    
    func searchReq(parameters: [String: AnyObject], completionHandler: @escaping (_ params: Products) -> ()) {
        Alamofire.request("\(url)api/products/search", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Products>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
            
        }
    }
    func searchFromBanner(parameters: [String: AnyObject], completionHandler: @escaping (_ params: Products) -> ()) {
        Alamofire.request("\(url)api/products/searchBanner", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Products>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
            
        }
    }
    func getSingleProduct(id: String,completionHandler: @escaping (_ params: SingleProduct) -> ()) {
        Alamofire.request("\(url)api/products/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<SingleProduct>) in
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
    
    func getContacts(completionHandler: @escaping (_ params: Contacts) -> ()) {
        Alamofire.request("\(url)api/contacts", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Contacts>) in
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
    func getBasketProduct(parameters: [String: AnyObject], completionHandler: @escaping (_ params: Products) -> ()) {
        Alamofire.request("\(url)api/products", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Products>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
            
        }
    }
    
    func sendAddress(parameters: [String: AnyObject], completionHandler: @escaping (_ params: ShopAdresses) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/adresses", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<ShopAdresses>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            }
            else {
                print("Сервер наебнулся")
            }
        }
    }
    
    func checktransaction(transactionId: String, completionHandler: @escaping (_ succ: CheckTranz) -> ()){
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        
        
        Alamofire.request(url + "api/transaction/check/\(transactionId)", method: .get, parameters: nil, headers: headers).responseObject{ (response: DataResponse<CheckTranz>) in
            
            let otvetResponse = response.result.value
            if (otvetResponse) != nil {
                completionHandler(otvetResponse!)
            }
        }
    }
    
    func sendCard(parameters: [String: AnyObject], completionHandler: @escaping (_ params: OplataObj) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/paycards/add", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<OplataObj>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
        }
    }
    
    func getUserAddress( completionHandler: @escaping (_ params: ShopAdresses) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/adresses", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<ShopAdresses>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
        }
    }
    func getUserCards( completionHandler: @escaping (_ params: Cards) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/paycards", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<Cards>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else{
                    if let msg = response.result.value {
                        print(msg)
                    } else {
                        print("Произошла какая-то ошибка")
                    }
                }
            } else {
                print("Сервер наебнулся")
            }
        }
    }

    
    func getUserData(completionHandler: @escaping (_ params: Profile) -> ()) {
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/users", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<Profile>) in
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
    
    func getShopAddresses(completionHandler: @escaping (_ params: ShopAdresses) -> ()) {
        Alamofire.request("\(url)api/adresses/shops", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<ShopAdresses>) in
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
    func getBanners(completionHandler: @escaping (_ params: Banners) -> ()) {
        Alamofire.request("\(url)api/banners", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Banners>) in
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

    func getCategories(completionHandler: @escaping (_ params: Categories) -> ()) {
        Alamofire.request("\(url)api/categories", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Categories>) in
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
    func getHistory(skip: String, limit: String,sort: String,completionHandler: @escaping (_ params: ProductHistoryRootClass) -> ()) {

        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/histories?skip=\(skip)&limit=\(limit)/&sorting=\(sort)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<ProductHistoryRootClass>) in
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
                self.view.stopLoading()
        }
    }
    func getHistoryDetail(id : String ,completionHandler: @escaping (_ params: Orders) -> ()) {
        
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/orders/\(id)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<Orders>) in
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
    func getPoints( origin: String, destination: String, completionHandler: @escaping (_ rotes: Destination) -> ()) {
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(googleKey)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseObject{
            (response: DataResponse<Destination>) in
            if let code = response.response?.statusCode{
                if code == 200{
                    if let cats = response.result.value {
                        completionHandler(cats)
                    }
                }else{
                    
                }
            }
        }
    }
    
    func checkOutRequest(jsonObject : [String : AnyObject] ,completionHandler: @escaping (_ params: Orders) -> ()) {
        
        let token = UserDefaults.standard.string(forKey: "token")
        let headers: HTTPHeaders = ["x-user-token": "BekArt \(token!)"]
        Alamofire.request("\(url)api/orders/", method: .post, parameters: jsonObject, encoding: JSONEncoding.default, headers: headers).responseObject{
            (response: DataResponse<Orders>) in
            print("RESPONSE", response)
            if response.response?.statusCode != nil {
                if (response.response?.statusCode)! < 202{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }else if (response.response?.statusCode)! == 404{
                    if let info = response.result.value {
                        completionHandler(info)
                    }
                }
                else {
                    print("Сервер наебнулся")
                }
            }
            
        }
    }
   
}
