//
//  LocationBasedNotificationViewController+Views.swift
//  NotificationsProject
//
//  Created by Jayde Jeong on 2022/11/10.
//

import UIKit
import MapKit

extension LocationBasedNotificationViewController {
    func setViews() {
        topStackView = UIStackView()
        topStackView.axis = .horizontal
        topStackView.alignment = .center
        topStackView.spacing = 20
        topStackView.sizeToFit()
        
        locationStatusLabel = UILabel()
        locationStatusLabel.text = "위치 권한 X"
        locationStatusLabel.sizeToFit()
        
        notificationStatusLabel = UILabel()
        notificationStatusLabel.text = "알림 권한 X"
        notificationStatusLabel.sizeToFit()
        
        topStackView.addArrangedSubview(locationStatusLabel)
        topStackView.addArrangedSubview(notificationStatusLabel)
        
        self.view.addSubview(topStackView)
    }
    
    func setMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        
        self.view.addSubview(mapView)
    }
    
    func setConstraints() {
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            topStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.topAnchor.constraint(equalTo: self.topStackView.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
