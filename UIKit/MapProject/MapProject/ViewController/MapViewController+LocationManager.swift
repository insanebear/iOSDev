//
//  MapViewController+LocationManager.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import MapKit

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus

        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        mapView.setCenter(coordinate: userLocation.coordinate, regionRadius: 2000)
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
