//
//  AddCookieLocationViewController.swift
//  CookieMeUp
//
//  Created by Sandra Flores on 4/22/18.
//  Copyright © 2018 CSUMB-CST495-Group-1. All rights reserved.
//

import UIKit
import GoogleMaps

class AddCookieLocationViewController: UIViewController{
    
    //------------------
    var locationManager = CLLocationManager()
    //lazy var mapView = GMSMapView()

    @IBOutlet weak var mapView = GMSMapView()
    
    
    
    
    // ------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // ---------
        let camera = GMSCameraPosition.camera(withLatitude: 36.651600, longitude: -121.797800, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: self.view.bounds, camera: camera)
        view = mapView
        
        // User Location
        locationManager.delegate = self as? CLLocationManagerDelegate
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 36.651600, longitude: -121.797800)
        marker.title = "My Pin"
        marker.snippet = "SCUMB"
        marker.map = mapView
        
        // ------
        
        // Do any additional setup after loading the view.
        
    }
    
   

    // ------
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       // Dispose of any resources that can be recreated.
        
    }


    /*
    MARK: - Navigation

    In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         Get the new view controller using segue.destinationViewController.
         Pass the selected object to the new view controller.
    }
    */

}


