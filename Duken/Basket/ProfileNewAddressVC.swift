//
//  ProfileNewAddressVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 22.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ProfileNewAddressVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    // MARK: - Variables
    let disableMarkerImage = UIImage(named: "markerGray")!.withRenderingMode(.alwaysOriginal)
    var locationManager = CLLocationManager()
    let camera = GMSCameraPosition.camera(withLatitude: 43.246172774545656, longitude: 76.925475932657719, zoom: 15.0)
    let date = NSDate()
    let calendar = NSCalendar.current

    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        size()
        mapSet()
        textSets()
        timePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    
    // MARK: - Outlets
    @IBOutlet var phoneText: UITextField!
    @IBOutlet var addressText: UITextField!
    @IBOutlet var myMap: GMSMapView!
    @IBOutlet var chooseOutlet: UIButton!
    @IBOutlet var addressView: UIView!
    @IBOutlet var okOutlet: UIButton!
    @IBOutlet var podezdText: UITextField!
    @IBOutlet var cancelOutlet: UIButton!
    @IBOutlet var kvText: UITextField!
    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var datePickerView: UIView!
    @IBOutlet var saveTimeOutlet: UIButton!
    @IBOutlet var timeView: UIView!
    
    
    // MARK: - Actions
    @IBAction func okPressed(_ sender: UIButton) {
        addressView.removeFromSuperview()
        view.addSubview(datePickerView)
    }
    @IBAction func selectPressed(_ sender: UIButton) {
        
    }
    @IBAction func cancelPressed(_ sender: UIButton) {
        addressView.removeFromSuperview()
    }
    @IBAction func saveTimePressed(_ sender: UIButton) {
    }
    
    // MARK: - Functions
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
        saveTimeOutlet.applyGradient()
        timeView.layer.borderWidth = 1
        timeView.layer.borderColor = #colorLiteral(red: 0.3442793489, green: 0.5794479251, blue: 0, alpha: 1)
        phoneText.layer.borderColor = UIColor.lightGray.cgColor
        phoneText.layer.borderWidth = 0.5
        kvText.layer.borderColor = UIColor.lightGray.cgColor
        kvText.layer.borderWidth = 0.5
        podezdText.layer.borderColor = UIColor.lightGray.cgColor
        podezdText.layer.borderWidth = 0.5
        addressText.layer.borderColor = UIColor.lightGray.cgColor
        addressText.layer.borderWidth = 0.5
        addressView.frame = CGRect(x: 0, y: 0, width: width, height: height)
        datePickerView.frame = CGRect(x: 0, y: 0, width: width, height: height)
    }
    func textSets() {
        let now = Date()
        
        let formatter = DateFormatter()
        
        formatter.timeZone = TimeZone.current
        
        formatter.dateFormat = "dd-MM HH:mm"
        
        let dateString = formatter.string(from: now)
         self.dateLabel.text = dateString
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: sender.date)
        if let day = components.day, let month = components.month, let year = components.year, let clock = components.hour, let minut = components.minute {
            var day2 = day
            let hour = calendar.component(.hour, from: date as Date)
            let curMinut = calendar.component(.minute, from: date as Date)
                if (clock * 60 + minut) - (hour * 60 + curMinut) < 60 {
                    day2 = day + 1
                    print("day2 is: \(day2)")
                }else {
                    day2 = day
                }
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
            
            self.dateLabel.text = "\(day2)-\(mon)  \(h):\(min)"
        }
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
        setMarkers(latitude: lat, longitude: long)
        getAddressInfo(lat: lat, long: long) { (address) in
            if let a = address.results?.count {
                if a > 0 {
                    if let b = address.results?[0].addressComponents?.count {
                        if b > 2 {
                            print(address.results![0].addressComponents![1].shortName!)
                            print(address.results![0].addressComponents![0].shortName!)
                            print(address.results![0].addressComponents![2].shortName!)
                            print(address.results![0].addressComponents![3].shortName!)
                            let num = address.results![0].addressComponents![0].shortName!
                            let street = address.results![0].addressComponents![1].shortName!
                            self.addressText.text = "\(street) \(num)"
                            self.view.addSubview(self.addressView)
                        }
                    }
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
