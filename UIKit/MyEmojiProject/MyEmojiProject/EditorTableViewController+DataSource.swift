//
//  EditorTableViewController+DataSource.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/25.
//

import UIKit

extension EditorTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // set a title by sections
        switch section {
        case 0: return "Emoji"
        case 1: return "Description"
        default:
            fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set a proper cell by sections
        switch indexPath.section {
        case 0: return self.emojiCell
        case 1: return self.descriptionCell
        default:
            fatalError("Unknown section")
        }
    }
}

