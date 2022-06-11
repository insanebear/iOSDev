//
//  MapSearchResultViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import UIKit
import MapKit

class MapSearchResultViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    var searchCompleter = MKLocalSearchCompleter()
    var searchResultCompletions: [MKLocalSearchCompletion] = []
//    var searchResults: [MKMapItem] = []
    var mapView: MKMapView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "검색"
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        
        searchCompleter.delegate = self
        
        setupSearchBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchBar.becomeFirstResponder()
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
            searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5)
        ])
    }
    
    func setupTableView() {
        tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
//    func updateSearchResults() {
//        guard let mapView = mapView else {
//            return
//        }
//        let request = MKLocalSearch.Request()
//        request.naturalLanguageQuery = searchBar.text
//
//        request.region = mapView.region
//
//        let search = MKLocalSearch(request: request)
//        search.start { response, error in
//            guard let response = response else {
//                return
//            }
//            self.searchResults = response.mapItems
//            self.tableView.reloadData()
//        }
//    }
}

extension MapSearchResultViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchCompleter.queryFragment = searchText
//        if searchText == "" {
//            self.searchResults = []
//            self.tableView.reloadData()
//        } else {
//            updateSearchResults()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension MapSearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        searchResults.count
        searchResultCompletions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let searchedItem = searchResults[indexPath.row]
//        cell.textLabel?.text = searchedItem.name
        let searchedItem = searchResultCompletions[indexPath.row]
        cell.textLabel?.text = searchedItem.title
        return cell
    }
}

extension MapSearchResultViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        searchResultCompletions = completer.results
        tableView.reloadData()
    }
}
