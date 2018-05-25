//
//  GoogleMapsViewController.swift
//  iHobby_Portfolio4
//
//  Created by Prajwal Ramamurthy on 5/21/18.
//  Copyright © 2018 Prajwal Ramamurthy. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation

class GoogleMapsViewController: UIViewController, CLLocationManagerDelegate, UISearchBarDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    
    @IBAction func SearchButton(_ sender: Any) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController, animated: true, completion: nil)
        
        
    }
    // initialize location manager
    let manager = CLLocationManager()
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // get the most recent position of the user
        // zoom in the map on that location
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
        var coordinate = CLLocationCoordinate2D(latitude: 28.5966, longitude: 81.3013)
        // location of the user
        let region = MKCoordinateRegion(center: coordinate, span: span)
        // set the map region
        map.setRegion(region, animated: true)
        var annotation = MKPointAnnotation()
        annotation.title = "Full Sail University"
        annotation.coordinate.latitude = 28.5966
        annotation.coordinate.longitude = 81.3013
        
        map.addAnnotation(annotation)
        
        //nadd the blue dot
        self.map.showsUserLocation = true
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // google API key
        GMSServices.provideAPIKey("AIzaSyCT-h1fDCLUaQleZ4qdAsZ4rNc2HeuF-JA")
        
        //
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
        
        
    }
    
    
    
    
    
}
