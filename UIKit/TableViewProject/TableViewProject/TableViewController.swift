//
//  TableViewController.swift
//  TableViewProject
//
//  Created by Jayde Jeong on 2022/05/22.
//

import UIKit

class TableViewController: UITableViewController {
    var characters: [String] = [
        "A", "B", "C", "D", "E"
     ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MyCustomCell.self, forCellReuseIdentifier: "\(MyCustomCell.self)")

        navigationItem.rightBarButtonItem = editButtonItem
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedChar = characters.remove(at: sourceIndexPath.row)
        characters.insert(movedChar, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 45
    }
    
    // MARK: - DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
////        cell.textLabel?.text = "\(indexPath.row + 1)"
//        cell.textLabel?.text = characters[indexPath.row]
//        cell.showsReorderControl = true
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCustomCell.self)", for: indexPath) as? MyCustomCell else {
            fatalError()
        }
        
        cell.configure(name: characters[indexPath.row])
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row+1)")
    }

}
