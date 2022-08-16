//
//  ViewController.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class ViewController: UIViewController {
    
    let items: [Item] = [
        Item(name: "Simple Card View", destination: SimpleCardViewController()),
        Item(name: "Card Collection View", destination: CardCollectionViewController(collectionViewLayout: UICollectionViewLayout())),
        Item(name: "Card Page View", destination: CardPageViewController()),
        Item(name: "Multi resources in one card", destination: MultiResourcesViewController()),
        Item(name: "Swipeable Card View", destination: SwipeableCardViewController()),
        Item(name: "Vertical Card View", destination: VerticalCardsViewController(collectionViewLayout: UICollectionViewLayout())),
        Item(name: "Unsplash API Sample - CollectionView", destination: UnsplashSampleViewController()),
        Item(name: "Card View with Additional Button", destination: ButtonCardViewController()),
    ]
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let navVC = navigationController else {
            fatalError("No navigation vc")
        }
        navVC.pushViewController(items[indexPath.row].destination, animated: true)
    }
}

struct Item {
    let name: String
    let destination: UIViewController
}
