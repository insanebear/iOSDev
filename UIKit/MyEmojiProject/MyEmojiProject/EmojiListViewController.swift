//
//  ViewController.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/24.
//

import UIKit

class EmojiListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEmoji(_:)))
        navigationItem.rightBarButtonItem = addButtonItem
        navigationItem.leftBarButtonItem = editButtonItem
        
        // register a tableView cell
        tableView.register(MyEmojiCell.self, forCellReuseIdentifier: "\(MyEmojiCell.self)")
        
        // add an notification observer to recognize the editor dismissal
        NotificationCenter.default.addObserver(self, selector: #selector(didDismissEditorViewController(_:)), name: .didDismissEditorViewController, object: nil)
    }
    
    func showEditor(emoji: Emoji?) {
        let editorVC = EditorTableViewController(emoji: emoji)
        
        let navVC = UINavigationController(rootViewController: editorVC)

        // present EditorTableViewController modally as a navigation view
        present(navVC, animated: true)
    }
    
    @objc func addEmoji(_ sender: UIBarButtonItem) {
        showEditor(emoji: nil)
    }
    
    @objc func didDismissEditorViewController(_ notification: Notification) {
        DispatchQueue.main.async {
            // reload data after the editor closed
            self.tableView.reloadData()
        }
    }
}

