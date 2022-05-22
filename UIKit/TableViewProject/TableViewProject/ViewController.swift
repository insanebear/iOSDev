//
//  ViewController.swift
//  TableViewProject
//
//  Created by Jayde Jeong on 2022/05/22.
//

import UIKit

class ViewController: UIViewController {
    var characters: [String] = [
        "A", "B", "C", "D", "E"
     ]
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonTapped(_:)))
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
    }
    
    @objc func editButtonTapped(_ sender: UIBarButtonItem) {
        let mode = tableView.isEditing
        tableView.setEditing(!mode, animated: true)
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row+1)")
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedChar = characters.remove(at: sourceIndexPath.row)
        characters.insert(movedChar, at: destinationIndexPath.row)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(indexPath.row + 1)"
        cell.textLabel?.text = characters[indexPath.row]
        cell.showsReorderControl = true
        return cell
    }
}
