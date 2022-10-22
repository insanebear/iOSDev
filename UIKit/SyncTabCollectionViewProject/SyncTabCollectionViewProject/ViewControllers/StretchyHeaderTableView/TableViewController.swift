//
//  TableViewController.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

class TableViewController: UIViewController {
    let tableView = UITableView(frame: .zero, style: .grouped)
    var dataSource: TableViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topHeaderView = StretchyHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 250))
        let image = UIImage(named: "image1")
        topHeaderView.configure(image: image)
        self.tableView.tableHeaderView = topHeaderView
        self.tableView.delegate = self
        
        configureDataSource()
        self.view.addSubview(self.tableView)
        
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func configureDataSource() {
        // register a cell
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // set a diffable datasource
        self.dataSource = TableViewDataSource(tableView: self.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            cell.textLabel?.text = "\(itemIdentifier)"
            
            return cell
        })
        
        self.dataSource.update(animatingDifferences: false)
        tableView.dataSource = self.dataSource
    }
}

extension TableViewController: UITableViewDelegate, UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let headerView = self.tableView.tableHeaderView as! StretchyHeaderView
        headerView.scrollViewDidScroll(scrollView: scrollView)
    }
}
