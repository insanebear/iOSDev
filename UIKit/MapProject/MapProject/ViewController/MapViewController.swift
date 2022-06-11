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
    let initCoordinate = CLLocationCoordinate2D(latitude: 37.51220874522728, longitude: 127.09822908736776)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        addPin(coordinate: initCoordinate)
    }
    
    func setupMap(){
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(mapView)
        
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

extension MKMapView {
    func setCenter(coordinate: CLLocationCoordinate2D, regionRadius: CLLocationDistance) {
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.setRegion(region, animated: true)
    }
}
