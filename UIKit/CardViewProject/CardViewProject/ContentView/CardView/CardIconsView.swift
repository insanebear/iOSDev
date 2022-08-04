//
//  CardIconsView.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/08/03.
//

import UIKit

class CardIconsView: UIStackView {
    private var cardIconViews: [CardIconView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.sizeToFit()
        self.spacing = 10
        self.axis = .horizontal
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCardIconViews(iconViews: [CardIconView]) {
        self.cardIconViews = iconViews
        
        for iconView in iconViews {
            self.addArrangedSubview(iconView)
        }
    }
}

class CardIconView: UIStackView {
    private let icon: UIImageView = {
        let imageView = UIImageView()
        imageView.sizeToFit()
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.axis = .vertical
        self.alignment = .center
        self.sizeToFit()
        
        // to use like a button
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: #selector(didTapIconView(_:)))
        self.addGestureRecognizer(tapGestureReconizer)
        self.isUserInteractionEnabled = true
        
        self.addArrangedSubview(icon)
        self.addArrangedSubview(title)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIcon(image: UIImage, color: UIColor = .white) {
        self.icon.image = image
        self.icon.tintColor = color
    }
    
    func setTitle(title: String, color: UIColor = .white) {
        self.title.text = title
        self.title.textColor = color
    }
    
    @objc func didTapIconView(_ sender: UIGestureRecognizer) {
        print(title.text)
    }
}

