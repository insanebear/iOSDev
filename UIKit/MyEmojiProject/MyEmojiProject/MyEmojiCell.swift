//
//  MyEmojiCell.swift
//  MyEmojiProject
//
//  Created by Jayde Jeong on 2022/05/24.
//

import UIKit

class MyEmojiCell: UITableViewCell {
    static let identifier = "myEmojiCell"
    
    private var emojiLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.sizeToFit()
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    private var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.sizeToFit()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textAlignment = .left
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    } ()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(emojiLabel)
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            descriptionLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            emojiLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(emoji: Emoji) {
        self.emojiLabel.text = emoji.emoji
        self.descriptionLabel.text = emoji.description
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emojiLabel.text = nil
        self.descriptionLabel.text = nil
    }
}
