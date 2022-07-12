//
//  LoginViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/11.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    private var authViewModel: AuthenticationViewModel
    
    let signinButton: GIDSignInButton = {
        let button = GIDSignInButton()
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
        
        signinButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        self.view.addSubview(signinButton)
        
        NSLayoutConstraint.activate([
            signinButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            signinButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            signinButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            signinButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20)
        ])
        
    }
    
    @objc func signIn(_ sender: GIDSignInButton) {
        // FIXME: Sign-in again does not work
        authViewModel.signIn()
    }
}
