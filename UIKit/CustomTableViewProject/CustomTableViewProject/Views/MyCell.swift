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
    private let customView = CustomView()

    var emoji: Emoji?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(didViewTapped(_:)))
        customView.addGestureRecognizer(tapGestureReconizer)

        contentView.addSubview(cellLeadingView)
        contentView.addSubview(extraInfoView)
        contentView.addSubview(customView)
        
        let favoriteImage = UIImage(systemName: "star.fill")
        let favoriteImageView = UIImageView(image: favoriteImage)
        accessoryView = favoriteImageView
        accessoryView?.isHidden = true
        
        self.showsReorderControl = true
        
        NSLayoutConstraint.activate([
            
            cellLeadingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellLeadingView.topAnchor.constraint(equalTo: self.topAnchor),
            cellLeadingView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cellLeadingView.widthAnchor.constraint(equalToConstant: 50),
            
            extraInfoView.centerXAnchor.constraint(equalTo: cellLeadingView.centerXAnchor),
            extraInfoView.topAnchor.constraint(equalTo: cellLeadingView.bottomAnchor, constant: -20),

            customView.leadingAnchor.constraint(equalTo: cellLeadingView.trailingAnchor, constant: 30),
            customView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            customView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            customView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            customView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure (num: Int, emoji: Emoji) {
        cellLeadingView.numberLabel.text = String(num)

        self.emoji = emoji
        if let emoji = self.emoji {
            self.customView.titleLabel.text = emoji.emoji
            self.customView.descriptionLabel.text = emoji.description
            
            extraInfoView.label.text = emoji.emoji
            
            if emoji.isFavorite {
                accessoryView?.isHidden = false
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.emoji = nil
        self.customView.titleLabel.text = nil
        self.customView.descriptionLabel.text = nil
        accessoryView?.isHidden = true
    }
    
    override func didAddSubview(_ subview: UIView) {
        /// To apply custom edit control and reorder control icons
        // FIXME: To display all cases (not working for hidden cells at first)
        if let originalIcon = subview.subviews.first as? UIImageView {
            originalIcon.removeFromSuperview()
        }
        var iconImage: UIImage!
        var newIconImageView: UIImageView!
        
        if subview.description.contains("UITableViewCellEditControl") {
            iconImage = UIImage(systemName: "x.circle.fill")
            newIconImageView = UIImageView(image: iconImage)
            
            subview.addSubview(newIconImageView)
        } else if subview.description.contains("UITableViewCellReorderControl") {
            iconImage = UIImage(systemName: "arrow.up.and.down")
            newIconImageView = UIImageView(image: iconImage)
            
            let subviewWidth = subview.frame.width
            let iconSize = CGSize(width: subviewWidth, height: subviewWidth)
            let origin = CGPoint(x: 0, y: self.frame.height/2 - iconSize.height/2)
            newIconImageView.frame = CGRect(origin: origin, size: iconSize)
            
            subview.addSubview(newIconImageView)
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
    
    // FIXME: background color only works for long touches.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        customView.backgroundColor = .lightGray
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        customView.backgroundColor = .none
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        customView.backgroundColor = .none
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

class CustomView: UIView {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        
        return label
    } ()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textAlignment = .left
        
        return label
    } ()
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor

        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        self.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
