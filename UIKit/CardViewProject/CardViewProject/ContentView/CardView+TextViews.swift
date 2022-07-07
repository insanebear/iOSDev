//
//  CardView+TextViews.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardTextView: UIStackView {
    let cardTitle: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    } ()
    
    var subtitle: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addArrangedSubview(cardTitle)
        self.addArrangedSubview(subtitle)
        
        self.sizeToFit()
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
