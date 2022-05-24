//
//  EditorTableViewController.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/24.
//

import UIKit

class EditorTableViewController: UITableViewController {
    var emoji: Emoji?
    
    var emojiCell: UITableViewCell!
    var emojiTextField: UITextField!
    
    var descriptionCell: UITableViewCell!
    var descriptionTextField: UITextField!
    
    var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView() // using STATIC cells to represent forms
    }
    
    init(emoji: Emoji?) {
        self.emoji = emoji
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        // TextField
        self.emojiTextField = UITextField()
        self.emojiTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionTextField = UITextField()
        self.descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        // Cell for TextField
        self.emojiCell = UITableViewCell()
        self.emojiCell.selectionStyle = .none // should not be able to be selected.
        self.emojiCell.contentView.addSubview(self.emojiTextField)
        
        self.descriptionCell = UITableViewCell()
        self.descriptionCell.selectionStyle = .none // should not be able to be selected.
        self.descriptionCell.contentView.addSubview(self.descriptionTextField)
        
        if let emoji = self.emoji {
            title = "Edit Name"
            self.emojiTextField.text = emoji.emoji
            self.descriptionTextField.text = emoji.description
        } else {
            title = "Add Name"
            self.emojiTextField.placeholder = "Enter an Emoji"
            self.descriptionTextField.placeholder = "Enter an Emoji Description"
        }
        
        NSLayoutConstraint.activate([
            self.emojiTextField.leadingAnchor.constraint(equalTo: self.emojiCell.leadingAnchor, constant: 20),
            self.emojiTextField.trailingAnchor.constraint(equalTo: self.emojiCell.trailingAnchor, constant: -20),
            self.emojiTextField.topAnchor.constraint(equalTo: self.emojiCell.topAnchor),
            self.emojiTextField.bottomAnchor.constraint(equalTo: self.emojiCell.bottomAnchor),
            
            self.descriptionTextField.leadingAnchor.constraint(equalTo: self.descriptionCell.leadingAnchor, constant: 20),
            self.descriptionTextField.trailingAnchor.constraint(equalTo: self.descriptionCell.trailingAnchor, constant: -20),
            self.descriptionTextField.topAnchor.constraint(equalTo: self.descriptionCell.topAnchor),
            self.descriptionTextField.bottomAnchor.constraint(equalTo: self.descriptionCell.bottomAnchor),
        ])
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // set a title by sections
        switch section {
        case 0: return "Emoji"
        case 1: return "Description"
        default:
            fatalError("Unknown section")
        }
    }
}
