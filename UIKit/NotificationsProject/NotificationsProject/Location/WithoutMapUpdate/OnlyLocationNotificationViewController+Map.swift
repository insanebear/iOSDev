//
//  OnlyLocationNotificationViewController+Map.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/11.
//

import UIKit
import MapKit

extension OnlyLocationNotificationViewController {
    func setupMonitoring(for places: [CLLocationCoordinate2D]) {
        // remove all pending notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // register location notification triggers using places
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            for place in places {
                let region = CLCircularRegion(center: place, radius: 100, identifier: UUID().uuidString)
                region.notifyOnEntry = true
                locationManager.startMonitoring(for: region)
                
                createNotificationTrigger(region: region)
            }
        }
    }
}

extension OnlyLocationNotificationViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            hasLocationAuth = true
//            locationManager.startUpdatingLocation()
        } else {
            hasLocationAuth = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        
        let coordinate = userLocation.coordinate
        mapView.setCenter(coordinate)
        print("\(coordinate.latitude), \(coordinate.longitude)")
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
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered in")
        locationManager.stopMonitoring(for: region)
        checkPendingNotifications()
    }
}
