//
//  NMapViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/14.
//

import UIKit
import NMapsMap

class NMapViewController: UIViewController {
    
    var mapView: NMFMapView!
    var searchBar: UISearchBar!

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
        mapView = NMFMapView(frame: self.view.frame)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            // ???: mapView topAnchor cannot be attached to other than self.view anchors. It crashes.
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.view.layoutMarginsGuide.bottomAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor)
        ])
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
