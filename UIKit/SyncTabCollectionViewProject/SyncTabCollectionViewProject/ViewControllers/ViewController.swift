//
//  ViewController.swift
//  SyncTabCollectionViewProject
//
//  Created by Jayde Jeong on 2022/10/05.
//

import UIKit

class ViewController: UITableViewController {
    let items: [ExampleItems] = [
        ExampleItems(name: "Table View with Stretchy Header", destination: TableViewController()),
        ExampleItems(name: "Sync Tab Collection View", destination: SyncTabCollectionViewController()),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the Navigation Bar background transparent
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = .white

        // Remove title and leave only chevron
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = ""
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
