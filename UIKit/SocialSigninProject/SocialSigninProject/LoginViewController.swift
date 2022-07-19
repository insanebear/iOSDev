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
    
    let googleSignInButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()

    var emailLabel: UILabel!
    var emailMethodSeperator: UILabel!
    var emailButtonStack: UIStackView!
    var emailSignUpButton: UIButton!
    var emailSignInButton: UIButton!
    var emailFeatureStack: UIStackView!

    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        googleSignInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        self.view.addSubview(googleSignInButton)
        
        setupEmailStack()

        NSLayoutConstraint.activate([
            googleSignInButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            googleSignInButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            googleSignInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            googleSignInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            
            emailFeatureStack.topAnchor.constraint(equalTo: self.googleSignInButton.bottomAnchor, constant: 40),
            emailFeatureStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
        
    }
    
    func setupEmailStack() {
        // Buttons related to email login
        emailSignInButton = UIButton()
        emailSignInButton.sizeToFit()
        emailSignInButton.setTitle("Sign in using Email", for: .normal)
        emailSignInButton.setTitleColor(.black, for: .normal)
        emailSignInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        emailMethodSeperator = UILabel()
        emailMethodSeperator.text = "- or -"
        emailMethodSeperator.sizeToFit()
        emailMethodSeperator.textColor = .lightGray

        emailSignUpButton = UIButton()
        emailSignUpButton.sizeToFit()
        emailSignUpButton.setTitle("Create a new account", for: .normal)
        emailSignUpButton.setTitleColor(.black, for: .normal)
        emailSignUpButton.addTarget(self, action: #selector(showSignupViewController), for: .touchUpInside)
        
        emailButtonStack = UIStackView()
        emailButtonStack.axis = .vertical
        emailButtonStack.alignment = .center
        emailButtonStack.spacing = 10
        emailButtonStack.addArrangedSubview(emailSignInButton)
        emailButtonStack.addArrangedSubview(emailMethodSeperator)
        emailButtonStack.addArrangedSubview(emailSignUpButton)
        
        // Section Label
        emailLabel = UILabel()
        emailLabel.text = "Email"
        emailLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        emailLabel.textColor = .darkGray

        // Email feature stack
        emailFeatureStack = UIStackView()
        emailFeatureStack.translatesAutoresizingMaskIntoConstraints = false
        emailFeatureStack.spacing = 20
        emailFeatureStack.axis = .vertical
        emailFeatureStack.alignment = .center
        emailFeatureStack.addArrangedSubview(emailLabel)
        emailFeatureStack.addArrangedSubview(emailButtonStack)
        
        view.addSubview(emailFeatureStack)
        
    }
    
    @objc func signIn(_ sender: UIButton) {
        authViewModel.signIn()
    }
    
    @objc func showSignupViewController(_ sender: UIButton) {
        present(RegistrationViewController(), animated: true)
    }
}
