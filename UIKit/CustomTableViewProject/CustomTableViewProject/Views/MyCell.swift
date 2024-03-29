//
//  MyCell.swift
//  CustomTableViewProject
//
//  Created by Jayde Jeong on 2022/09/07.
//

import UIKit

class MyCell: UITableViewCell {

    static let identifier = "myCell"
    
    private let cellLeadingView = CellLeadingView()
    private let extraInfoView = ExtraInfoView()
    private let textViews = TextViews()

    var emoji: Emoji? {
        didSet {
            if let emoji = emoji {
                accessoryView?.isHidden = emoji.isFavorite ? false : true
                
                textViews.titleLabel.text = emoji.emoji
                textViews.descriptionLabel.text = emoji.description
                extraInfoView.label.text = emoji.emoji

                let icon = UIImage(systemName: emoji.icon)
                cellLeadingView.iconView.image = icon
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // customViewGestureRecognizer
        let textViewsTapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(didViewTapped(_:)))
        textViews.addGestureRecognizer(textViewsTapGestureReconizer)
        
        // cellLeadingView GestureRecognizer
        let iconViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didLeadingIconViewTapped(_:)))
        cellLeadingView.iconView.addGestureRecognizer(iconViewTapGestureRecognizer)
        
        let addButtonTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didLeadingAddButtonTapped(_:)))
        cellLeadingView.addButton.addGestureRecognizer(addButtonTapGestureRecognizer)
        
        // add subviews
        contentView.addSubview(cellLeadingView)
        contentView.addSubview(extraInfoView)
        contentView.addSubview(textViews)
        
        // accessory view
        let favoriteImage = UIImage(systemName: "star.fill")
        let favoriteImageView = UIImageView(image: favoriteImage)
        accessoryView = favoriteImageView
        accessoryView?.isHidden = true
        
        // autolayout alignments
        NSLayoutConstraint.activate([
            
            cellLeadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellLeadingView.topAnchor.constraint(equalTo: self.topAnchor),
            cellLeadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellLeadingView.widthAnchor.constraint(equalToConstant: 50),
            
            extraInfoView.leadingAnchor.constraint(equalTo: cellLeadingView.leadingAnchor),
            extraInfoView.bottomAnchor.constraint(equalTo: cellLeadingView.bottomAnchor, constant: -15),
            extraInfoView.widthAnchor.constraint(equalToConstant: 10),
            extraInfoView.heightAnchor.constraint(equalToConstant: 10),

            textViews.leadingAnchor.constraint(equalTo: cellLeadingView.trailingAnchor, constant: 30),
            textViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textViews.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            textViews.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            textViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(emoji: Emoji) {
        self.emoji = emoji
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        if editing {
            let icon = UIImage(systemName: "x.circle.fill")
            cellLeadingView.iconView.image = icon
            cellLeadingView.iconView.tintColor = .red
            cellLeadingView.iconView.isUserInteractionEnabled = true
            cellLeadingView.addButton.isHidden = false
        } else {
            if let emoji = emoji {
                let icon = UIImage(systemName: emoji.icon)
                cellLeadingView.iconView.image = icon
                cellLeadingView.iconView.tintColor = .white
                cellLeadingView.iconView.isUserInteractionEnabled = false
                cellLeadingView.addButton.isHidden = true
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emoji = nil
    }
    
    override func didAddSubview(_ subview: UIView) {
        /// To apply custom edit control and reorder control icons
        if let originalIcon = subview.subviews.first as? UIImageView {
            originalIcon.removeFromSuperview()
        }
        var iconImage: UIImage!
        var newIconImageView: UIImageView!
        
        if subview.description.contains("UITableViewCellReorderControl") {
            iconImage = UIImage(systemName: "arrow.up.and.down")
            newIconImageView = UIImageView(image: iconImage)
            
            let subviewWidth = subview.frame.width
            let iconSize = CGSize(width: subviewWidth, height: subviewWidth)
            let origin = CGPoint(x: 0, y: self.frame.height/2 - iconSize.height/2)
            newIconImageView.frame = CGRect(origin: origin, size: iconSize)
            newIconImageView.translatesAutoresizingMaskIntoConstraints = false
            
            subview.addSubview(newIconImageView)
            
            NSLayoutConstraint.activate([
                newIconImageView.centerXAnchor.constraint(equalTo: subview.centerXAnchor),
                newIconImageView.centerYAnchor.constraint(equalTo: subview.centerYAnchor),
            ])
        }
        
        /// To hide unexpectedly appearing separator
        if subview.description.contains("_UITableViewCellVerticalSeparator") {
            subview.isHidden = true
        }
    }
}

extension MyCell {
    @objc func didViewTapped(_ sender: UITapGestureRecognizer) {
        if let emoji = self.emoji {
            let editorVC = EditorViewController(emoji: emoji)
            let navVC = UINavigationController(rootViewController: editorVC)
            
            // modal presentation for a navigation view controller
            if let parentVC = self.parentViewController {
                parentVC.present(navVC, animated: true)
            }
        }
    }
    
    @objc func didLeadingAddButtonTapped(_ sender: UITapGestureRecognizer) {
        if let emoji = emoji {
            let index = Emoji.emojis.indexOfEmoji(with: emoji.id)
            let editorVC = EditorViewController(index: index)
            let navVC = UINavigationController(rootViewController: editorVC)
            
            // modal presentation for a navigation view controller
            if let parentVC = self.parentViewController {
                parentVC.present(navVC, animated: true)
            }
        }
    }
    
    @objc func didLeadingIconViewTapped(_ sender: UITapGestureRecognizer) {
        if let superView = self.superview as? UITableView {
            superView.perform(Selector(("_swipeToDeleteCell:")), with: self)
        }
    }
    
    // FIXME: background color only works for long touches.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        textViews.backgroundColor = .lightGray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        textViews.backgroundColor = .none
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        textViews.backgroundColor = .none
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
}
