//
//  LocationBasedNotificationViewController.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/09.
//

import UIKit
import MapKit

class LocationBasedNotificationViewController: UIViewController {
    /// views
    var topStackView: UIStackView!

    var locationStatusLabel: UILabel!
    var notificationStatusLabel: UILabel!
    
    var mapView: MKMapView!

    /// location manager and notification center
    var locationManager: CLLocationManager!
    var notificationCenter = UNUserNotificationCenter.current()
    
    /// checking properties
    var hasLocationAuth = false {
        didSet {
            locationStatusLabel.text = hasLocationAuth ? "Location O" : "Location X"
        }
    }
    var hasNotificationAuth = false {
        didSet {
            notificationStatusLabel.text = hasNotificationAuth ? "Notification O" : "Notification X"
        }
    }
    
    var sampleDestinations: [CLLocationCoordinate2D] = [
        CLLocationCoordinate2D(latitude: 37.5239, longitude: 126.9806)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true
        
        notificationCenter.delegate = self
        
        setViews()
        setMapView()
        setConstraints()
        
        checkAuthorizations()
    }
    
    func checkAuthorizations() {
        // location
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            hasLocationAuth = true
            locationManager.startUpdatingLocation() // start location service
        case .notDetermined:
            // called only one time in app's life time.
            hasLocationAuth = false
            locationManager.requestWhenInUseAuthorization() // request authorization
        default:
            hasLocationAuth = false
            
            // no auth, send a user to settings
            // !!!: In production, you should describe why they have to be sent first.
            openSettings()
        }
        
        // notification
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                let status = settings.authorizationStatus
                
                switch status {
                case .authorized:
                    self.hasNotificationAuth = true
                    self.setupMonitoring(for: self.sampleDestinations)
                case .notDetermined:
                    self.hasNotificationAuth = false
                    self.requestNotificationAuth(center: self.notificationCenter)
                default:
                    self.hasNotificationAuth = false
                    self.openSettings()
                }
            }
            
        }
    }
    
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil) // open this app's settings
            }
        }
    }
}

