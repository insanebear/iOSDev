//
//  EmojiListViewController+DataSource.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/25.
//

import UIKit

extension EmojiListViewController {
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
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Emoji.sampleEmojis.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedEmoji = Emoji.sampleEmojis[indexPath.row]
        showEditor(emoji: selectedEmoji)
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedChar = Emoji.sampleEmojis.remove(at: sourceIndexPath.row)
        Emoji.sampleEmojis.insert(movedChar, at: destinationIndexPath.row)
    }
}
