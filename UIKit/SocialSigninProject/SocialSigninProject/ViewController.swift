//
//  ViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/11.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    private var authViewModel: AuthenticationViewModel
    
    let signoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign out", for: .normal)
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
        
        signoutButton.addTarget(self, action: #selector(signOut), for: .touchUpInside)
        self.view.addSubview(signoutButton)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            signoutButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor),
            signoutButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            signoutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
    }

    @objc func signOut(_ sender: UIButton) {
        authViewModel.signOut()
        
        let viewController = LoginViewController(authViewModel: self.authViewModel)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        
        self.present(viewController, animated: true) {
            print("Logout succeeded")
        }
    }
}

