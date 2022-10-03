//
//  ViewController+DataSource.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/10/03.
//

import UIKit

class EmojiDataSource: UITableViewDiffableDataSource<Int, Emoji> {
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, Emoji>
    
    func update(animatingDifferences: Bool = true) {
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(Emoji.emojis, toSection: 0)
        
        apply(snapshot, animatingDifferences: animatingDifferences) // apply snapshot to data source
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let emoji = self.itemIdentifier(for: indexPath) else { return }
            Emoji.remove(emoji: emoji)
            update()
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        guard
            sourceIndexPath != destinationIndexPath,
            sourceIndexPath.section == destinationIndexPath.section,
            let emojiToMove = itemIdentifier(for: sourceIndexPath),
            let emojiAtDestination = itemIdentifier(for: destinationIndexPath)
        else {
            apply(snapshot(), animatingDifferences: true)
            return
        }
        Emoji.reorder(emojiToMove: emojiToMove, emojiAtDestination: emojiAtDestination)
        update()
    }
}
