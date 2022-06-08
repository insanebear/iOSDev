//
//  CardCollectionViewHeaderView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/08.
//

import UIKit

class CardCollectionViewHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "cardCollectionViewHeaderView"
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false

        addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
