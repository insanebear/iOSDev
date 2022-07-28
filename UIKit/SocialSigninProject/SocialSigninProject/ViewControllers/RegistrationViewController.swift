//
//  RegistrationViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/19.
//

import UIKit

class RegistrationViewController: UIViewController {
    internal var authViewModel: AuthenticationViewModel
    
    var nameField: InputFieldView!
    var emailField: InputFieldView!
    var passwordField: InputFieldView!
    
    var fieldStackView: UIStackView!
    
    let doneButton = DoneButton()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
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
        self.view.backgroundColor = .white
        
        setupTextFields()
        
        cancelButton.addTarget(self, action: #selector(cancel(_:)), for: .touchUpInside)
        view.addSubview(cancelButton)
        
        doneButton.addTarget(self, action: #selector(done(_:)), for: .touchUpInside)
        view.addSubview(doneButton)

        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 10),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            
            doneButton.topAnchor.constraint(equalTo: fieldStackView.bottomAnchor, constant: 40),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupTextFields() {
        // name field
        nameField = InputFieldView()
        nameField.setTitle("Name")
        nameField.setPlaceholder("Enter your name")
        nameField.setErrorMessage(with: "Please enter your name")
        
        // email field
        emailField = InputFieldView()
        emailField.setAutocapitalization(type: .none)
        emailField.setTitle("E-mail")
        emailField.setPlaceholder("Enter your email")
        emailField.setErrorMessage(with: "Please enter a valid email address")
        
        // password field
        passwordField = InputFieldView()
        passwordField.setTitle("Password")
        passwordField.setPlaceholder("Enter password")
        passwordField.setTextEntrySecure(true)
        passwordField.setErrorMessage(with: "At least 6 digits or characters")
        
        fieldStackView = UIStackView()
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.axis = .vertical
        fieldStackView.alignment = .leading
        fieldStackView.spacing = 30
        fieldStackView.addArrangedSubview(nameField)
        fieldStackView.addArrangedSubview(emailField)
        fieldStackView.addArrangedSubview(passwordField)
        
        self.view.addSubview(fieldStackView)
        
        NSLayoutConstraint.activate([
            fieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            fieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            fieldStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: UIScreen.main.bounds.height/4)
        ])
    }
}
