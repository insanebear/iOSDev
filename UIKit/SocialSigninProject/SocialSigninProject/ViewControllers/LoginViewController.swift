//
//  LoginViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/11.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    internal var authViewModel: AuthenticationViewModel
    
    var loginFeatureStack: UIStackView! // contains all login features

    var googleSignInButton: GIDSignInButton! // for Google sign-in

    var emailFeatureStack: UIStackView! // contains email sign-in and sign-up

    var emailSectionLabel: UILabel!
    
    var emailLoginStack: UIStackView! // contains email, password fields and sign-in button
    var emailField: InputFieldView!
    var passwordField: InputFieldView!
    var emailSignInButton: DoneButton!
    
    var emailMethodSeperator: UILabel!
    
    var emailSignUpButton: UIButton! // to navigate email sign-up page


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
        
        setupGoogleSignInButton()
        setupEmailFeatureStack()

        loginFeatureStack = UIStackView()
        loginFeatureStack.translatesAutoresizingMaskIntoConstraints = false
        loginFeatureStack.alignment = .center
        loginFeatureStack.spacing = 10
        loginFeatureStack.axis = .vertical
        loginFeatureStack.addArrangedSubview(googleSignInButton)
        loginFeatureStack.addArrangedSubview(emailFeatureStack)

        self.view.addSubview(loginFeatureStack)
        
        NSLayoutConstraint.activate([
            loginFeatureStack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginFeatureStack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
        
    }
    
    func setupGoogleSignInButton() {
        googleSignInButton = GIDSignInButton()
        googleSignInButton.addTarget(self, action: #selector(googleSignIn), for: .touchUpInside)
        googleSignInButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
    }
    
    func setupEmailFeatureStack() {
        // section Label
        emailSectionLabel = UILabel()
        emailSectionLabel.text = "Email"
        emailSectionLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        emailSectionLabel.textColor = .darkGray

        // email login stack
        setupEmailLoginStack()
        
        // email sign in / sign up seperator
        emailMethodSeperator = UILabel()
        emailMethodSeperator.text = "- or -"
        emailMethodSeperator.sizeToFit()
        emailMethodSeperator.textColor = .lightGray
        
        // email signup button
        emailSignUpButton = UIButton()
        emailSignUpButton.sizeToFit()
        emailSignUpButton.setTitle("Create a new account", for: .normal)
        emailSignUpButton.setTitleColor(.black, for: .normal)
        emailSignUpButton.addTarget(self, action: #selector(showSignupViewController), for: .touchUpInside)
        
        
        // email feature stack
        emailFeatureStack = UIStackView()
        emailFeatureStack.spacing = 20
        emailFeatureStack.axis = .vertical
        emailFeatureStack.alignment = .center
        
        emailFeatureStack.addArrangedSubview(emailSectionLabel)
        emailFeatureStack.addArrangedSubview(emailLoginStack)
        emailFeatureStack.addArrangedSubview(emailMethodSeperator)
        emailFeatureStack.addArrangedSubview(emailSignUpButton)
    }
    
    func setupEmailLoginStack(){
        // email field
        emailField = InputFieldView()
        emailField.setAutocapitalization(type: .none)
        emailField.setTitle("E-mail")
        emailField.setPlaceholder("Enter your email")
        
        // password field
        passwordField = InputFieldView()
        passwordField.setTitle("Password")
        passwordField.setPlaceholder("Enter password")
        passwordField.setTextEntrySecure(true)
        
        // email sign in button
        emailSignInButton = DoneButton()
        emailSignInButton.setTitle("Sign in", for: .normal)
        emailSignInButton.addTarget(self, action: #selector(emailSignIn), for: .touchUpInside)
        
        // -- email login stack
        emailLoginStack = UIStackView()
        emailLoginStack.axis = .vertical
        emailLoginStack.alignment = .center
        emailLoginStack.spacing = 10
        emailLoginStack.addArrangedSubview(emailField)
        emailLoginStack.addArrangedSubview(passwordField)
        emailLoginStack.addArrangedSubview(emailSignInButton)
    }
}
