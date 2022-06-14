//
//  NMapViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import UIKit
import NMapsMap

class NMapViewController: UIViewController {
    
    var nMapView: NMFNaverMapView!
    var searchBar: UISearchBar!
    
    let DEFAULT_CAMERA_POSITION = NMGLatLng(lat: 37.5666102, lng: 126.9783881)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        
        setupMap()
        setupSearchBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupMap() {
        nMapView = NMFNaverMapView(frame: self.view.frame)
        nMapView.translatesAutoresizingMaskIntoConstraints = false
        nMapView.showLocationButton = true
        nMapView.showZoomControls = false
        self.view.addSubview(nMapView)
        
        NSLayoutConstraint.activate([
            // ???: mapView topAnchor cannot be attached to other than self.view anchors. It crashes.
            nMapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            nMapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            nMapView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            nMapView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        ])
        
        nMapView.mapView.moveCamera(
            NMFCameraUpdate(position:
                                NMFCameraPosition(DEFAULT_CAMERA_POSITION,
                                                                               zoom: 14,
                                                                               tilt: 0,
                                                                               heading: 0))
        )
        
        let userLocationMark = nMapView.mapView.locationOverlay
        userLocationMark.circleOutlineWidth = 0
        userLocationMark.location = NMFCameraPosition(
            DEFAULT_CAMERA_POSITION,
            zoom: 14,
            tilt: 0,
            heading: 0
        ).target ///
        userLocationMark.hidden = false
        userLocationMark.icon = NMFOverlayImage(name: "imgLocationDirection", in: Bundle.naverMapFramework())
        userLocationMark.circleColor = .lightGray
        
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = true
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(searchBar)

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension NMapViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // Move to MapSearchResultViewController when a user tapped a search bar
        let searchResultListViewController = NMapSearchResultViewController()
        
        self.navigationItem.backButtonTitle = "NMap" // indicates MapViewController
        self.navigationItem.backButtonDisplayMode = .minimal // shows on MapSearchResultViewController for MapViewController
        
        searchBar.resignFirstResponder()
        self.navigationController?.pushViewController(searchResultListViewController, animated: true)
    }
}
