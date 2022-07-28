//
//  RegistrationViewController+Actions.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/24.
//

import UIKit
import FirebaseAuth

extension RegistrationViewController {
    @objc func cancel(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func done(_ sender: UIButton) {
        
        if let email = emailField.getText(),
           let password = passwordField.getText(),
           let name = nameField.getText() {
            
            let isEmailValid = validateEmail(email: email)
            let isPasswordValid = validatePassword(password: password)
            let isNameValid = name == "" ? false : true
            
            if !isNameValid {
                nameField.showErrorMessage(true)
            }
            
            if !isEmailValid {
                emailField.showErrorMessage(true)
            }
            
            if !isPasswordValid {
                passwordField.showErrorMessage(true)
            }
            
            if isEmailValid && isPasswordValid && isNameValid {
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        print("Error occurred while creating account using email: \(error)")
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { error in // save displayName
                        if let error = error {
                            print(error.localizedDescription)
                        }
                        
                        self.authViewModel.signIn(type: .email, email: email, password: password)
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
