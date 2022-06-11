//
//  MapViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    // ???: Warning failed to parse font key token here. Cannot find the reason yet.
    
    var mapView: MKMapView!
    let myLocations: [MyLocation] = LocationStore().myLocations
    
    let defaultCoordinate = CLLocationCoordinate2D(latitude: 37.5366, longitude: 126.9771)
    var currentUserLocation: CLLocation?
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // check authorization status to get a user location
        checkPermission()
        
        setupMap()
    }
    
    func setupMap(){
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true

        mapView.setCenter(coordinate: defaultCoordinate) // if there's no location permission, use default coordinate.
        mapView.addAnnotations(myLocations)

        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
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
            // TODO: Can open the app settings in the phone Settings?
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
    }
    
    func addPin(coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case let myAnnotation as MyLocation:
            let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "myLocation") as? MKMarkerAnnotationView ?? MKMarkerAnnotationView(annotation: myAnnotation, reuseIdentifier: "myLocation")
            
            annotationView.glyphImage = UIImage(systemName: "star")
            annotationView.titleVisibility = .visible
            return annotationView
        default:
            return nil
        }
    }
}

extension MKMapView {
    func setCenter(coordinate: CLLocationCoordinate2D, regionRadius: CLLocationDistance = 10000) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(region, animated: true)
    }
}
