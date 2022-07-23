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
    
    var loginFeatureStack: UIStackView! // contains all login features

    var googleSignInButton: GIDSignInButton! // for Google sign-in

    var emailFeatureStack: UIStackView! // contains email sign-in and sign-up

    var emailSectionLabel: UILabel!
    
    var emailLoginStack: UIStackView! // contains email, password fields and sign-in button
    var emailLabel: UILabel!
    var emailField: UITextField!
    var emailStack: UIStackView!
    var passwordLabel: UILabel!
    var passwordField: UITextField!
    var passwordStack: UIStackView!
    var emailSignInButton: UIButton!
    
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
        googleSignInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
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
        emailLabel = UILabel()
        emailLabel.text = "E-mail"
        emailLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        emailLabel.textColor = .black
        
        emailField = UITextField()
        emailField.attributedPlaceholder = NSAttributedString(
            string: "Enter your email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        emailField.textColor = .black
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.contentHorizontalAlignment = .leading
        emailField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        
        // email stack
        emailStack = UIStackView()
        emailStack.axis = .vertical
        emailStack.spacing = 10
        emailStack.alignment = .leading
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailField)
        
        // password field
        passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        passwordLabel.textColor = .black
        
        
        passwordField = UITextField()
        passwordField.isSecureTextEntry = true
        passwordField.attributedPlaceholder = NSAttributedString(
            string: "Enter password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        passwordField.textColor = .black
        passwordField.layer.borderWidth = 1
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        
        // password stack
        passwordStack = UIStackView()
        passwordStack.axis = .vertical
        passwordStack.spacing = 10
        passwordStack.alignment = .leading
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordField)
        
        // email sign in button
        emailSignInButton = UIButton()
        emailSignInButton.backgroundColor = .systemBlue
        emailSignInButton.layer.cornerRadius = 10
        emailSignInButton.setTitle("Sign in", for: .normal)
        emailSignInButton.setTitleColor(.white, for: .normal)
        emailSignInButton.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/5).isActive = true
        emailSignInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        
        // -- email login stack
        emailLoginStack = UIStackView()
        emailLoginStack.axis = .vertical
        emailLoginStack.alignment = .center
        emailLoginStack.spacing = 10
        emailLoginStack.addArrangedSubview(emailStack)
        emailLoginStack.addArrangedSubview(passwordStack)
        emailLoginStack.addArrangedSubview(emailSignInButton)
    }
    
    @objc func signIn(_ sender: UIButton) {
        authViewModel.signIn()
    }
    
    @objc func showSignupViewController(_ sender: UIButton) {
        present(RegistrationViewController(), animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
