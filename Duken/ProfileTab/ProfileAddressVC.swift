//
//  ProfileAddressVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 15.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class ProfileAddressVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    // MARK: - Variables
    let disableMarkerImage = UIImage(named: "markerGray")!.withRenderingMode(.alwaysOriginal)
    var locationManager = CLLocationManager()
    let camera = GMSCameraPosition.camera(withLatitude: 43.246172774545656, longitude: 76.925475932657719, zoom: 15.0)
    var city = ""
    var houseNum = ""
    var street = ""
    var district = ""
    var lat = Double()
    var lng = Double()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        size()
        mapSet()
        viewHeight.constant = 0
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    // MARK: - Outlets
    
    @IBOutlet var viewHeight: NSLayoutConstraint!
    @IBOutlet var addressText: UITextField!
    @IBOutlet var myMap: GMSMapView!
    @IBOutlet var chooseOutlet: UIButton!
    @IBOutlet var addressView: UIView!
    @IBOutlet var okOutlet: UIButton!
    @IBOutlet var podezdText: UITextField!
    @IBOutlet var cancelOutlet: UIButton!
    @IBOutlet var kvText: UITextField!
    @IBOutlet var houseNumText: UITextField!
    // MARK: - Actions
    
    @IBAction func okPressed(_ sender: UIButton) {
            if addressText.text != "" {
                if houseNumText.text != "" {
                    self.city = "Алматы"
                    self.street = addressText.text!
                    self.houseNum = houseNumText.text ?? " "
                    self.send()
                } else {
                    self.city = "Алматы"
                    self.street = addressText.text!
                    self.houseNum = "1"
                    self.send()
                }
            } else {
                alertView(title: "Заполните все поля в строке Адрес", message: " ")
            }
    }
    
    func alertView(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func selectPressed(_ sender: UIButton) {
        
    }
    @IBAction func cancelPressed(_ sender: UIButton) {
        addressView.removeFromSuperview()
    }
    // MARK: - Functions
    func send(){
        let parameters = ["city": city,
                          "flatNum": kvText.text!,
                          "houseNum": houseNum,
                          "street": street,
                          "district": district,
                          "lat": lat,
                          "lng": lng] as [String: AnyObject]
        
        sendAddress(parameters: parameters) { (info) in
            self.getAlert()
        }
    }
    
    
    func mapSet(){
        myMap.delegate = self
        myMap.camera = camera
        myMap.settings.compassButton = true
        myMap.settings.myLocationButton = true
    }

    func size() {
        okOutlet.applyGradient()
        chooseOutlet.applyGradient()
        cancelOutlet.blackGrad()
        kvText.layer.borderColor = UIColor.lightGray.cgColor
        kvText.layer.borderWidth = 0.5
        houseNumText.layer.borderColor = UIColor.lightGray.cgColor
        houseNumText.layer.borderWidth = 0.5
        podezdText.layer.borderColor = UIColor.lightGray.cgColor
        podezdText.layer.borderWidth = 0.5
        addressText.layer.borderColor = UIColor.lightGray.cgColor
        addressText.layer.borderWidth = 0.5
        addressView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    func getAlert(){
        let alert = UIAlertController(title: nil, message: "Адрес успешно добавлен", preferredStyle: UIAlertControllerStyle.alert)
        // add an action (button)
        alert.addAction(UIAlertAction(title: "Ок", style: UIAlertActionStyle.default, handler:{ (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
    // MARK: - MapView
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        myMap.isMyLocationEnabled = true
    }
 
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate.latitude)
        print(coordinate.longitude)
        let lat = "\(coordinate.latitude)"
        let long = "\(coordinate.longitude)"
        self.lat = coordinate.latitude
        self.lng = coordinate.longitude
        setMarkers(latitude: lat, longitude: long)
        getAddressInfo(lat: lat, long: long) { (address) in
            if let a = address.results?.count {
                if a > 0 {
                    if let b = address.results?[0].addressComponents?.count {
                        if b > 2 {
                            print(address.results![0].addressComponents![1].shortName!)
                            print(address.results![0].addressComponents![0].shortName!)
                            print(address.results![0].addressComponents![2].shortName!)
                            self.city = (address.results![0].addressComponents![3].shortName!)
                            self.houseNum = address.results![0].addressComponents![0].shortName!
                            self.street = address.results![0].addressComponents![1].shortName!
                            self.district = address.results![0].addressComponents![2].shortName!
                            let street = address.results![0].addressComponents![1].shortName!
                            self.addressText.text = "\(street)"
                            self.houseNumText.text = self.houseNum
                            self.view.addSubview(self.addressView)
                        }
                    }
                } else {
                    self.view.addSubview(self.addressView)
                }
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        self.view.endEditing(true)
    }
    
    func setMarkers(latitude: String, longitude: String) {
        myMap.clear()
        let UnselectmarkerView = UIImageView(image: disableMarkerImage)
        let a = CLLocationCoordinate2D(latitude: Double(latitude)!, longitude: Double(longitude)!)
            let marker = GMSMarker()
            marker.iconView = UnselectmarkerView
            marker.position = a
            marker.map = myMap
    }
}




