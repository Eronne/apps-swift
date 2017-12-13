//
//  ViewController.swift
//  Distance
//
//  Created by LETUE Erwann on 13/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var totalMeters = 0.0 as Double
    let locationManager = CLLocationManager()
    var previousLocation: CLLocation?
    
    var tracking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        if let previousLocation = previousLocation {
            let distance = previousLocation.distance(from: currentLocation)
            totalMeters = totalMeters + distance
            distanceLabel.text = String(totalMeters)
        }
        previousLocation = currentLocation
        
        mapView.setCenter(currentLocation.coordinate, animated: true)
    }

    @IBAction func resetAction(_ sender: Any) {
        totalMeters = 0
        distanceLabel.text = "0"
    }
    
    
    @IBAction func toggleTracking(_ sender: Any) {
        tracking = !tracking
        if tracking {
            let status = CLLocationManager.authorizationStatus()
        
            if status == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            } else if status == .authorizedWhenInUse || status == .authorizedAlways {
                locationManager.startUpdatingLocation()
            }
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status != .authorizedWhenInUse && status != .authorizedAlways {
            locationManager.stopUpdatingLocation()
        } else if tracking {
            locationManager.startUpdatingLocation()
        }
    }
}

