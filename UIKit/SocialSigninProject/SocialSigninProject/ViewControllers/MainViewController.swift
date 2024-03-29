//
//  MainViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/11.
//

import UIKit
import GoogleSignIn

class MainViewController: UIViewController {
    private var authViewModel: AuthenticationViewModel
    
    var userProfileView: UserProfileView!

    let signoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    let disconeectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Disconnect", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textLabel = UILabel()
        textLabel.text = "Hello, world!"
        textLabel.textColor = .systemRed
        textLabel.sizeToFit()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textLabel)
        
        setupUserProfileView()
        
        signoutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        disconeectButton.addTarget(self, action: #selector(disconnect), for: .touchUpInside)

        let buttonStackView = UIStackView()
        buttonStackView.axis = .horizontal
        buttonStackView.alignment = .center
        buttonStackView.spacing = 10
        buttonStackView.addArrangedSubview(disconeectButton)
        buttonStackView.addArrangedSubview(signoutButton)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(buttonStackView)

        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor),
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            userProfileView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            userProfileView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
    }
    
    func setupUserProfileView() {
        guard let userInfo = self.authViewModel.userInfo else {
            fatalError("Cannot read current user")
        }
        
        userProfileView = UserProfileView(userInfo: userInfo)
        userProfileView.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(userProfileView)
    }

    @objc func signOut(_ sender: UIButton) {
        authViewModel.signOut()
    }
    @objc func disconnect(_ sender: UIButton) {
        authViewModel.disconnect()
    }
}

