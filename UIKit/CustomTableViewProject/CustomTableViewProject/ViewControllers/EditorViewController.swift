//
//  EditorViewController.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/22.
//

import UIKit

class EditorViewController: UITableViewController {
    /// static table view
    var emoji: Emoji?
    
    var emojiCell: UITableViewCell!
    var emojiTextField: UITextField!
    
    var descriptionCell: UITableViewCell!
    var descriptionTextField: UITextField!
    
    var favoriteCell: UITableViewCell!
    var favoriteSwitch: UISwitch!
    
    var saveButton: UIBarButtonItem!
    var doneButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!

    private var isAddingNewEmoji = false

    override func viewDidLoad() {
        super.viewDidLoad()

        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didDoneTapped(_:)))
        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didSaveTapped(_:)))
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelTapped(_:)))
        
        navigationItem.rightBarButtonItem = isAddingNewEmoji ? saveButton : doneButton
        navigationItem.leftBarButtonItem = cancelButton
        setupStaticTableView()
    }
    
    init(emoji: Emoji?) {
        self.emoji = emoji
        self.isAddingNewEmoji = emoji == nil ? true : false
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStaticTableView() {
        /// UITextField, UISwitch and UITableViewCell
        
        // Emoji
        self.emojiTextField = UITextField()
        self.emojiTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.emojiTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.emojiCell = UITableViewCell()
        self.emojiCell.selectionStyle = .none // not selectable
        self.emojiCell.contentView.addSubview(self.emojiTextField)
        
        // Description
        self.descriptionTextField = UITextField()
        self.descriptionTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.descriptionTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionCell = UITableViewCell()
        self.descriptionCell.selectionStyle = .none // not selectable
        self.descriptionCell.contentView.addSubview(self.descriptionTextField)
        
        // Favorite
        self.favoriteSwitch = UISwitch()
        self.favoriteSwitch.translatesAutoresizingMaskIntoConstraints = false
        
        self.favoriteCell = UITableViewCell()
        self.favoriteCell.selectionStyle = .none // not selectable
        self.favoriteCell.contentView.addSubview(self.favoriteSwitch)
        
        // Default values for Emoji and Description fields
        if let emoji = self.emoji {
            title = "Edit Name"
            self.emojiTextField.text = emoji.emoji
            self.descriptionTextField.text = emoji.description
            self.favoriteSwitch.isOn = emoji.isFavorite
        } else {
            title = "Add Name"
            self.emojiTextField.placeholder = "Enter an Emoji"
            self.descriptionTextField.placeholder = "Enter an Emoji Description"
            self.favoriteSwitch.isOn = false
        }
        
        // TextField and Switch Alignments in TableViewCell
        NSLayoutConstraint.activate([
            self.emojiTextField.leadingAnchor.constraint(equalTo: self.emojiCell.leadingAnchor, constant: 20),
            self.emojiTextField.trailingAnchor.constraint(equalTo: self.emojiCell.trailingAnchor, constant: -20),
            self.emojiTextField.topAnchor.constraint(equalTo: self.emojiCell.topAnchor),
            self.emojiTextField.bottomAnchor.constraint(equalTo: self.emojiCell.bottomAnchor),
            
            self.descriptionTextField.leadingAnchor.constraint(equalTo: self.descriptionCell.leadingAnchor, constant: 20),
            self.descriptionTextField.trailingAnchor.constraint(equalTo: self.descriptionCell.trailingAnchor, constant: -20),
            self.descriptionTextField.topAnchor.constraint(equalTo: self.descriptionCell.topAnchor),
            self.descriptionTextField.bottomAnchor.constraint(equalTo: self.descriptionCell.bottomAnchor),
            
            self.favoriteSwitch.centerYAnchor.constraint(equalTo: self.favoriteCell.centerYAnchor),
            self.favoriteSwitch.leadingAnchor.constraint(equalTo: self.favoriteCell.leadingAnchor, constant: 10)
        ])
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    // MARK: - DataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // set a title by sections
        switch section {
        case 0: return "Emoji"
        case 1: return "Description"
        case 2: return "Favorite"
        default:
            fatalError("Unknown section")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // set a proper cell by sections
        switch indexPath.section {
        case 0: return self.emojiCell
        case 1: return self.descriptionCell
        case 2: return self.favoriteCell
        default:
            fatalError("Unknown section")
        }
    }
}

extension EditorViewController {

    @objc func didCancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        let emojiText = emojiTextField.text ?? ""
        let descriptionText = emojiTextField.text ?? ""
        doneButton.isEnabled = !emojiText.isEmpty && !descriptionText.isEmpty
    }
    
    @objc func didDoneTapped(_ sender: UIBarButtonItem) {
        if let emojiText = emojiTextField.text,
           let descriptionText = descriptionTextField.text {
            guard var emoji = emoji else {
                return
            }

            emoji.emoji = emojiText
            emoji.description = descriptionText
            emoji.isFavorite = favoriteSwitch.isOn
            
            let index = Emoji.sampleEmojis.indexOfEmoji(with: emoji.id)
            Emoji.sampleEmojis[index] = emoji
        }

        dismiss(animated: true) {
            // Notify that the editor is closing
            NotificationCenter.default.post(name: .didDismissEditorViewController, object: nil)
        }
    }
    
    @objc func didSaveTapped(_ sender: UIBarButtonItem) {
        if let emojiText = emojiTextField.text,
           let descriptionText = descriptionTextField.text {
            let newEmoji = Emoji(emoji: emojiText, description: descriptionText, isFavorite: favoriteSwitch.isOn)
            Emoji.sampleEmojis.append(newEmoji)
            print(newEmoji)
        }
        
        dismiss(animated: true) {
            // Notify that the editor is closing
            NotificationCenter.default.post(name: .didDismissEditorViewController, object: nil)
        }
    }
}

extension Notification.Name {
    static let didDismissEditorViewController = Notification.Name("didDismissEditorViewController")
}
