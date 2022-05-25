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
    
    var doneButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!

    private var isAddingNewEmoji = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didDoneTapped(_:)))
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didCancelTapped(_:)))
        
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.leftBarButtonItem = cancelButton
        setupView() // using STATIC cells to represent forms
        updateSaveButtonState()
    }
    
    init(emoji: Emoji?) {
        self.emoji = emoji
        self.isAddingNewEmoji = emoji == nil ? true : false
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didCancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    func setupView() {
        
        // TextField
        self.emojiTextField = UITextField()
        self.emojiTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        self.emojiTextField.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionTextField = UITextField()
        self.descriptionTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
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
    
    func updateSaveButtonState() {
        let emojiText = emojiTextField.text ?? ""
        let descriptionText = emojiTextField.text ?? ""
        doneButton.isEnabled = !emojiText.isEmpty && !descriptionText.isEmpty
    }
    
    @objc func didDoneTapped(_ sender: UIBarButtonItem) {
        if let emojiText = emojiTextField.text,
           let descriptionText = descriptionTextField.text {
            
            if isAddingNewEmoji {
                let newEmoji = Emoji(emoji: emojiText, description: descriptionText)
                Emoji.sampleEmojis.append(newEmoji)
            } else {
                guard var emoji = emoji else {
                    return
                }

                emoji.emoji = emojiText
                emoji.description = descriptionText
                
                let index = Emoji.sampleEmojis.indexOfEmoji(with: emoji.id)
                Emoji.sampleEmojis[index] = emoji
            }
        }

        dismiss(animated: true) {
            // Notify that the editor is closing
            NotificationCenter.default.post(name: .didDismissEditorViewController, object: nil)
        }
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: - Delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}

extension Notification.Name {
    static let didDismissEditorViewController = Notification.Name("didDismissEditorViewController")
}
