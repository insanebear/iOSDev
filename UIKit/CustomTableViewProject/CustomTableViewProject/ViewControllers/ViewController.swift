//
//  ViewController.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/06.
//

import UIKit

class ViewController: UITableViewController {
    var dataSource: EmojiDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = editButtonItem

        // datasource and snapshot
        configureDataSource()
        dataSource.update()
        tableView.dataSource = dataSource
        
        tableView.separatorStyle = .none
        tableView.allowsSelection = false // to use a custom selecting action
        
        // add an notification observer to recognize the editor dismissal
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissEditorViewController(_:)), name: .didDismissEditorViewController, object: nil)
    }

    // MARK: - DataSource
    
    func configureDataSource() {
        // register a cell
        tableView.register(MyCell.self, forCellReuseIdentifier: "\(MyCell.self)")
        
        // set a diffable datasource
        dataSource = EmojiDataSource(tableView: self.tableView, cellProvider: { tableView, indexPath, itemIdentifier in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCell.self)", for: indexPath) as? MyCell else {
                return UITableViewCell()
            }
            cell.configure(emoji: itemIdentifier)

            return cell
        })
    }
    
    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
}

extension ViewController {
    
    @objc func didDismissEditorViewController(_ notification: Notification) {
        DispatchQueue.main.async {
            // reload data after the editor closed
            guard let dataSource = self.tableView.dataSource as? EmojiDataSource else { return }
            dataSource.update(animatingDifferences: false)
        }
    }
}
