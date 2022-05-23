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
        navigationItem.rightBarButtonItem = editButtonItem
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(MyCustomCell.self, forCellReuseIdentifier: "\(MyCustomCell.self)")

        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: true)
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
//        return .none
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            characters.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 45
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
}
