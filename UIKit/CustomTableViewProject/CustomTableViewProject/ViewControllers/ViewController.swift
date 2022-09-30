//
//  ViewController.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/06.
//

import UIKit

class ViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEmoji(_:)))
        navigationItem.rightBarButtonItems = [addButtonItem, editButtonItem]
        
        tableView.register(MyCell.self, forCellReuseIdentifier: "\(MyCell.self)")
        tableView.separatorStyle = .none
        tableView.allowsSelection = false // to use a custom selecting action
        
        // add an notification observer to recognize the editor dismissal
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissEditorViewController(_:)), name: .didDismissEditorViewController, object: nil)
    }

    // MARK: - DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Emoji.sampleEmojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCell.self)", for: indexPath) as? MyCell else {
            return UITableViewCell()
        }
        let idx = indexPath.row
        let emoji = Emoji.sampleEmojis[idx]
        cell.configure(emoji: emoji)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Emoji.sampleEmojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movingEmoji = Emoji.sampleEmojis.remove(at: sourceIndexPath.row)
        Emoji.sampleEmojis.insert(movingEmoji, at: destinationIndexPath.row)
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
    
    @objc func addEmoji(_ sender: UIBarButtonItem) {
        let editorVC = EditorViewController(emoji: nil)
        let navVC = UINavigationController(rootViewController: editorVC)

        // modal presentation for a navigation view controller
        present(navVC, animated: true)
    }
    
    @objc func didDismissEditorViewController(_ notification: Notification) {
        DispatchQueue.main.async {
            // reload data after the editor closed
            self.tableView.reloadData()
        }
    }
}
