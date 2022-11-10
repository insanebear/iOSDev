//
//  LocationBasedNotificationViewController+Map.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/10.
//

import UIKit
import MapKit

extension LocationBasedNotificationViewController {
    func setupMonitoring(for places: [CLLocationCoordinate2D]) {
        // remove all pending notifications
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        // register location notification triggers using places
        if CLLocationManager.isMonitoringAvailable(for: CLCircularRegion.self) {
            for place in places {
                let region = CLCircularRegion(center: place, radius: 100, identifier: UUID().uuidString)
                region.notifyOnEntry = true
                locationManager.startMonitoring(for: region)

                let content = UNMutableNotificationContent()
                content.title = "Hello from NotificationsProject!"
                content.body = "You've arrived in the destination region 😌"
                content.sound = .default
                
                let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
                createNotificationRequest(content: content, trigger: trigger)
            }
        }
    }
    
    func createNotificationRequest(content: UNMutableNotificationContent, trigger: UNLocationNotificationTrigger) {
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString,
                                            content: content,
                                            trigger: trigger)

        // Schedule the request with the system.
        notificationCenter.add(request) { (error) in
           if error != nil {
               // Handle any errors.
               print("Error: \(String(describing: error))")
           }
        }
        
        checkPendingNotifications()
    }
}

extension LocationBasedNotificationViewController: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let status = locationManager.authorizationStatus
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            hasLocationAuth = true
            locationManager.startUpdatingLocation()
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

extension MKMapView {
    func setCenter(_ coordinate: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 600, animated: Bool = true) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(region, animated: animated)
    }
}
