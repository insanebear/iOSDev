//
//  TagCell.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/10.
//

import UIKit

class TagCell: UICollectionViewCell {
    static let identifier = "tagViewCell"
    
    private var tagView: TagView = TagView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(tagView)
        
        NSLayoutConstraint.activate([
            tagView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String, isTappable: Bool=true) {
        tagView.setText(with: text)
        if !isTappable {
            tagView.removeGestureRecognizer()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        tagView.setText(with: "")
    }
}

