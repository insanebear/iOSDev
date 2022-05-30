//
//  TextCell.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/05/29.
//

import UIKit

class TextCell: UICollectionViewCell {
    static let reuseIdentifier = "textCell"
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.textColor = .black
        label.sizeToFit()
        label.textAlignment = .center
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .systemGreen
        
        label.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(item: Int) {
        label.text = "\(item)"
    }
}
