//
//  EmojiCell.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/17.
//

import UIKit

class EmojiCell: UICollectionViewCell {
    static let reuseIdentifier = "emojiCell"
    
    private var emojiLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.sizeToFit()
        
        return label
    } ()
    private var notesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.sizeToFit()
        
        return label
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let stackView = UIStackView(arrangedSubviews: [emojiLabel, notesLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.sizeToFit()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)

        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemGray.cgColor
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
//            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(emoji: EmojisController.Emoji) {
        emojiLabel.text = "\(emoji.emoji)"
        notesLabel.text = "\(emoji.notes)"
    }
}
