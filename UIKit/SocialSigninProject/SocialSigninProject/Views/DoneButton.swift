//
//  DoneButtonView.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/24.
//

import UIKit

class DoneButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 10
        self.setTitle("Done", for: .normal)
        self.setTitleColor(.white, for: .normal)
        self.sizeToFit()
        self.contentEdgeInsets = UIEdgeInsets(top: 12, left: 20, bottom: 12, right: 20)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
