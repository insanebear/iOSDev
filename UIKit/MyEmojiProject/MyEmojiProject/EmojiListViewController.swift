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
            self.tableView.reloadData()
        }
    }

    // MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedChar = Emoji.sampleEmojis.remove(at: sourceIndexPath.row)
        Emoji.sampleEmojis.insert(movedChar, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEmoji = Emoji.sampleEmojis[indexPath.row]
        showEditor(emoji: selectedEmoji)
    }
}

