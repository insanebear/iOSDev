//
//  RegistrationViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/19.
//

import UIKit
import FirebaseAuth

class RegistrationViewController: UIViewController {
    
    var nameLabel: UILabel!
    var nameField: UITextField!
    var nameStack: UIStackView!
    
    var emailLabel: UILabel!
    var emailField: UITextField!
    var emailStack: UIStackView!
    var emailErrorMessage: UILabel!

    var passwordLabel: UILabel!
    var passwordField: UITextField!
    var passwordStack: UIStackView!
    var passwordErrorMessage: UILabel!
    
    var fieldStackView: UIStackView!
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    } ()

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
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.widthAnchor.constraint(equalToConstant: 120),
            doneButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupTextFields() {
        setupNameFields()
        setupEmailFields()
        setupPasswordFields()
        
        fieldStackView = UIStackView()
        fieldStackView.translatesAutoresizingMaskIntoConstraints = false
        fieldStackView.axis = .vertical
        fieldStackView.alignment = .leading
        fieldStackView.spacing = 30
        fieldStackView.addArrangedSubview(nameStack)
        fieldStackView.addArrangedSubview(emailStack)
        fieldStackView.addArrangedSubview(passwordStack)
        
        self.view.addSubview(fieldStackView)
        
        NSLayoutConstraint.activate([
            fieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            fieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            fieldStackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: UIScreen.main.bounds.height/4)
        ])
    }
    
    func setupNameFields() {
        nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        nameLabel.textColor = .black
        
        nameField = UITextField()
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        )
        nameField.textColor = .black
        nameField.layer.borderWidth = 1
        nameField.layer.borderColor = UIColor.lightGray.cgColor
        nameField.contentHorizontalAlignment = .leading
        nameField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20).isActive = true
        nameField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        
        nameStack = UIStackView()
        nameStack.axis = .vertical
        nameStack.alignment = .leading
        nameStack.addArrangedSubview(nameLabel)
        nameStack.addArrangedSubview(nameField)
        nameStack.spacing = 10
    }
    
    func setupEmailFields() {
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
        emailField.tag = 0
        emailField.delegate = self
        emailField.layer.borderWidth = 1
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.contentHorizontalAlignment = .leading
        emailField.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height/20).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width-40).isActive = true
        
        emailErrorMessage = UILabel()
        emailErrorMessage.text = "Please enter a valid email address"
        emailErrorMessage.font = UIFont.preferredFont(forTextStyle: .caption1)
        emailErrorMessage.textColor = .red
        emailErrorMessage.isHidden = true
        
        emailStack = UIStackView()
        emailStack.axis = .vertical
        emailStack.alignment = .leading
        emailStack.addArrangedSubview(emailLabel)
        emailStack.addArrangedSubview(emailField)
        emailStack.addArrangedSubview(emailErrorMessage)
        emailStack.spacing = 10
    }
    
    func setupPasswordFields() {
        passwordLabel = UILabel()
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont.preferredFont(forTextStyle: .title2)
        passwordLabel.textColor = .black
        
        passwordField = UITextField()
        passwordField.tag = 1
        passwordField.delegate = self
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
        
        passwordErrorMessage = UILabel()
        passwordErrorMessage.text = "At least 6 digits or characters"
        passwordErrorMessage.font = UIFont.preferredFont(forTextStyle: .caption1)
        passwordErrorMessage.textColor = .red
        passwordErrorMessage.isHidden = true
        
        passwordStack = UIStackView()
        passwordStack.axis = .vertical
        passwordStack.alignment = .leading
        passwordStack.addArrangedSubview(passwordLabel)
        passwordStack.addArrangedSubview(passwordField)
        passwordStack.addArrangedSubview(passwordErrorMessage)
        passwordStack.spacing = 10
    }
    
    @objc func cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func done(_ sender: UIButton) {
        // TODO: Save name
        // save info
        if let email = emailField.text, let password = passwordField.text {
            let isEmailValid = validateEmail(email: email)
            let isPasswordValid = validatePassword(password: password)
            
            if !isEmailValid {
                emailErrorMessage.isHidden = false
            }
            
            if !isPasswordValid {
                passwordErrorMessage.isHidden = false
            }
            
            if isEmailValid && isPasswordValid {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Error occurred while creating account using email: \(error)")
                    }
                }
                self.dismiss(animated: true)
            }
        }
    }
    
    func validateEmail(email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        
        return emailPredicate.evaluate(with: email)
    }
    
    func validatePassword(password: String) -> Bool {
        // check only the length condition here
        if password.count < 6 {
            return false
        }
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 { // email
            emailErrorMessage.isHidden = true
        }
        if textField.tag == 1 { // password
            passwordErrorMessage.isHidden = true
        }
    }
}
