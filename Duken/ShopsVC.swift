//
//  ShopsVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 22.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ShopsVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    

    // MARK: - Variables
    var locationManager = CLLocationManager()
    let camera = GMSCameraPosition.camera(withLatitude: 43.246172774545656, longitude: 76.925475932657719, zoom: 15.0)
    let disableMarkerImage = UIImage(named: "icon_map")!.withRenderingMode(.alwaysOriginal)
    let markerImage = UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal)
    var marker = [GMSMarker]()
    
    var addresses : ShopAdresses?
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        mapSet()
    }

    // MARK: - Outlets
    
    @IBOutlet var myMap: GMSMapView!
    
    // MARK: - Actions
    
    
    // MARK: - Functions
    func getAddressReq() {
        getShopAddresses { (info) in
            self.addresses = info
            if let count = self.addresses?.adresses?.count {
                if count > 0 {
                    self.setMarkers()
                }
            }
        }
    }
    func mapSet(){
        
        myMap.delegate = self
        myMap.camera = camera
        myMap.settings.compassButton = true
//        myMap.settings.myLocationButton = true
        getAddressReq()
        
    }
    func setMarkers() {
        
        let UnselectmarkerView = UIImageView(image: disableMarkerImage)

        marker = []
        for i in 0..<self.addresses!.adresses!.count {
            let mark = GMSMarker()
            let lat = addresses!.adresses![i].coordinates?.lat
            let lng = addresses!.adresses![i].coordinates?.lng
            let point = CLLocationCoordinate2D(latitude: Double(lat!)!, longitude: Double(lng!)!)
            let title = addresses!.adresses![i].street! + " \(addresses!.adresses![i].houseNum!)"
            marker.append(mark)
            marker[i].iconView = UnselectmarkerView
            marker[i].position = point
            marker[i].title = title
            marker[i].snippet = "India"
            marker[i].map = myMap
        }
    }
    
    // MARK: - MapView
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView? {
        let markerView = UIImageView(image: markerImage)
        let UnselectmarkerView = UIImageView(image: disableMarkerImage)
        for i in 0..<self.marker.count {
            self.marker[i].iconView = UnselectmarkerView
        }
        marker.iconView = markerView
        marker.iconView?.shadow()
        let inf = Bundle.main.loadNibNamed("infoWindow", owner: self, options: nil)?.first as! CustomInfo
        inf.addressLabel.text = marker.title
        marker.infoWindowAnchor = CGPoint(x: 2.2, y: 1.8)
        inf.frame.size = CGSize(width: 150, height: 80)
        inf.shadow()
        inf.sendSubview(toBack: marker.iconView!)
        marker.iconView?.bringSubview(toFront: inf)
        return inf
    }
}




