//
//  CardView+TextViews.swift
//  CardViewProject
//
//  Created by Jayde Jeong on 2022/06/07.
//

import UIKit

class CardBasicInfoView: UIStackView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    } ()
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addArrangedSubview(titleLabel)
        self.addArrangedSubview(subTitleLabel)
        
        self.sizeToFit()
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}

class CardDetailInfoView: UIStackView {
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        
        return label
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        self.addArrangedSubview(contentLabel)
        
        self.sizeToFit()
        self.axis = .vertical
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setContents(content: String) {
        contentLabel.text = content
    }
}
