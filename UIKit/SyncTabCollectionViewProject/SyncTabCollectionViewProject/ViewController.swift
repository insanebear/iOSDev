//
//  ViewController.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

class ViewController: UITableViewController {
    let items: [ExampleItems] = [
        ExampleItems(name: "Sync Tab Table View", destination: TableViewController()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(items[indexPath.row].destination, animated: true)
    }
}

struct ExampleItems {
    let name: String
    let destination: UIViewController
}
