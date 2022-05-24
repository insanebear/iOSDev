//
//  ViewController.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/24.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = editButtonItem
        
        // register a tableView cell
        tableView.register(MyEmojiCell.self, forCellReuseIdentifier: "\(MyEmojiCell.self)")
    }

    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedChar = Emoji.sampleEmojis.remove(at: sourceIndexPath.row)
        Emoji.sampleEmojis.insert(movedChar, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Emoji.sampleEmojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    // MARK: - DataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Emoji.sampleEmojis.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyEmojiCell.self)", for: indexPath) as? MyEmojiCell else {
            fatalError()
        }
        let emoji = Emoji.sampleEmojis[indexPath.row]
        cell.configure(emoji: emoji)
        
        return cell
    }

}

