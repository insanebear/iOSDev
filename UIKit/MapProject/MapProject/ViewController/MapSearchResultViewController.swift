//
//  MapSearchResultViewController.swift
//  MapProject
//
//  Created by Jayde Jeong on 2022/06/11.
//

import UIKit

class MapSearchResultViewController: UIViewController {
    
    var searchBar: UISearchBar!
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "검색"
        self.view.backgroundColor = UIColor(named: "backgroundColor")
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        setupSearchBar()
        setupTableView()
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        
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
}

extension MapSearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
