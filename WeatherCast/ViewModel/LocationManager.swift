//
//  LocationViewModel.swift
//  WeatherCast
//
//  Created by JETSMobileMini1 on 11/02/2024.
//

import Foundation
import CoreLocation

class LocationViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?
    @Published var locationStatus: CLAuthorizationStatus?
    override init() {
        super.init()
        setupLocationManager()
    }

    func setupLocationManager() {

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            userLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: \(error)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
           locationStatus = manager.authorizationStatus
          
       }
}
