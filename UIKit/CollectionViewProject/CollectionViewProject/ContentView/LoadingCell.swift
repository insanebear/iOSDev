//
//  LoadingCell.swift
//  CollectionViewProject
//
//  Created by Jayde Jeong on 2022/06/01.
//

import UIKit

class LoadingCell: UICollectionViewCell {
    static let reuseIdentifier = "loadingCell"
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(indicator)
        indicator.startAnimating()
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
