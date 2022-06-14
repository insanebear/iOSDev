//
//  NMapViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import UIKit
import NMapsMap

class NMapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let mapView = NMFMapView(frame: view.frame)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
