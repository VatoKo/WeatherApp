//
//  LocationAccessible.swift
//  WeatherApp
//
//  Created by Vakhtang Kostava on 18.08.21.
//

import UIKit
import CoreLocation

protocol LocationAccessible: CLLocationManagerDelegate {
    var locationManager: CLLocationManager { get set }
    func setupLocationManager()
}

extension LocationAccessible {
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 200
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
}
