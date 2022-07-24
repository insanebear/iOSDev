//
//  UserProfileView.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/14.
//

import UIKit
import GoogleSignIn

class UserProfileView: UIView {
    private var userInfo: UserInfo!
    
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
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    } ()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    } ()
    
    convenience init(userInfo: UserInfo) {
        self.init(frame: .zero)
        self.userInfo = userInfo
        
        setName()
        setEmail()
        setImage()
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(emailLabel)

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
        if let name = userInfo.name {
            nameLabel.text = "\(name)"
            self.addSubview(nameLabel)
        }
    }
    
    func setEmail() {
        if let email = userInfo.email {
            emailLabel.text = "\(email)"
            self.addSubview(emailLabel)
        }
    }

    func setImage() {
        profileImageView.layer.cornerRadius = 10
        profileImageView.clipsToBounds = true
        
        if let imageUrl = userInfo.profileImage,
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
