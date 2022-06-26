//
//  LocationManager.swift
//  Weather
//
//  Created by Jayde Jeong on 2022/06/26.
//

import CoreLocation
import UIKit

class LocationManager: NSObject, ObservableObject {
    let locationManager = CLLocationManager()
    @Published var currentLocation: CLLocation = CLLocation(latitude: 33.51041348076148,
                                                            longitude: 126.49138558399349)
    @Published var currentAddress: String = ""
    
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        checkPermission()
    }
    
    func checkPermission() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            // if a proper permission has been given, start location service
            locationManager.startUpdatingLocation()
        case .notDetermined:
            // if permission request has never been asked, ask for it
            locationManager.requestWhenInUseAuthorization()
        default:
            // else, move to the phone Settings
            // actually, there should be a dialog noticing that it's gonna move to Settings, but skipped in here.
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
    
    func getAddress(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                fatalError(error.localizedDescription)
            }
            
            guard let placemark = placemarks?.first else { return }
            
            if let city = placemark.locality,
               let state = placemark.administrativeArea {
                DispatchQueue.main.async {
                    self.currentAddress = "\(city), \(state)"
                }
            } else {
                DispatchQueue.main.async {
                    self.currentAddress = "Address Unknown"
                }
            }
        }
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus

        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        self.getAddress(location: userLocation)
        self.currentLocation = userLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let clError = error as? CLError else { return }
        
        switch clError {
        case CLError.denied: // didn't get authorized
            print("Access denied")
        default:
            print("Something went wrong")
        }
    }
}
