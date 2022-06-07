//
//  CardView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardView: UIView {
    
    var cardImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        cardImageView.contentMode = .scaleAspectFill
        cardImageView.sizeToFit()
        cardImageView.image = UIImage(named: "image1")
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardImageView)
        
        NSLayoutConstraint.activate([
            cardImageView.topAnchor.constraint(equalTo: self.topAnchor),
            cardImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            cardImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            cardImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
