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
    
    let mapView = MKMapView()
    let initCoordinate = CLLocationCoordinate2D(latitude: 37.5366, longitude: 126.9771)
    let myLocations: [MyLocation] = LocationStore().myLocations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        
        // Add annotations
        addPin(coordinate: initCoordinate)
        mapView.addAnnotations(myLocations)
    }
    
    func setupMap(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        // Set a center when the map is initially loaded
        mapView.setCenter(coordinate: initCoordinate, regionRadius: 1000)
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor)
        ])
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
