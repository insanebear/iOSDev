//
//  UserProfileView.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/14.
//

import UIKit
import GoogleSignIn

class UserProfileView: UIView {
    private var user: User?
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.sizeToFit()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .green
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    } ()
    
    convenience init(user: User) {
        self.init(frame: .zero)
        self.user = user
        
        setName()
        setImage()
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameLabel)
        
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: stackView.topAnchor),
            self.bottomAnchor.constraint(equalTo: stackView.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setName() {
        if let user = user {
            nameLabel.text = "\(user.name)"
            self.addSubview(nameLabel)
            
            NSLayoutConstraint.activate([
                nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
                nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        }
    }
    
    func setImage() {
        let dimension = 45 * UIScreen.main.scale
        profileImageView.layer.cornerRadius = dimension/2
        profileImageView.clipsToBounds = true
        
        if let user = user {
            if let imageUrl = user.profileImage,
               let data = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            } else {
                self.profileImageView.image = UIImage(systemName: "person.fill")
            }
        }
    }
}
