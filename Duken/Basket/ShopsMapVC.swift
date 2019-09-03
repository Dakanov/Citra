//
//  ShopsMapVC.swift
//  Duken
//
//  Created by Dakanov Sultan on 20.08.2018.
//  Copyright © 2018 Dakanov Sultan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class ShopsMapVC: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {
    // MARK: - Variables
    var locationManager = CLLocationManager()
    let camera = GMSCameraPosition.camera(withLatitude: 43.246172774545656, longitude: 76.925475932657719, zoom: 15.0)
    
    let markerImage = UIImage(named: "marker")!.withRenderingMode(.alwaysOriginal)
    let disableMarkerImage = UIImage(named: "markerGray")!.withRenderingMode(.alwaysOriginal)
    var marker = [GMSMarker]()
    var titles = ["с. Новостройка,Абая 12", "Казыбек Би район, 100012", "с. Новостройка,Абая, 12"]

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapSet()
        selectOutlet.applyGradient()
    }

    // MARK: - Outlets
    
    @IBOutlet var myMap: GMSMapView!
    @IBOutlet var selectOutlet: UIButton!
    
    // MARK: - Actions
    
    @IBAction func choosePressed(_ sender: UIButton) {
    }
    
    // MARK: - Functions
    func mapSet(){
        myMap.delegate = self
        myMap.camera = camera
        myMap.settings.compassButton = true
        myMap.settings.myLocationButton = true
        setMarkers()
    }
    
    func setMarkers() {
        let UnselectmarkerView = UIImageView(image: disableMarkerImage)
        let a = CLLocationCoordinate2D(latitude: 43.246172774545656, longitude: 76.925475932657719)
        let b = CLLocationCoordinate2D(latitude: 43.232992220760373, longitude: 76.878945305943489)
        let c = CLLocationCoordinate2D(latitude: 43.225158107894231, longitude: 76.910100840032101)
        let points = [a,b,c]
        marker = []
        for i in 0..<points.count {
            let mark = GMSMarker()
            marker.append(mark)
            marker[i].iconView = UnselectmarkerView
            marker[i].position = points[i]
            marker[i].title = titles[i]
            marker[i].snippet = "India"
            marker[i].map = myMap
        }
    }
    
    // MARK: - Map
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print(coordinate)
    }


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

class CustomInfo: UIView {
    @IBOutlet var addressLabel: UILabel!
}
