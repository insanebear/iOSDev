//
//  LoginViewController+Actions.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/24.
//

import UIKit

extension LoginViewController {
    @objc func emailSignIn(_ sender: UIButton) {
        let email = emailField.getText()
        let password = passwordField.getText()
        
        authViewModel.signIn(type: .email, email: email, password: password)
    }
    
    @objc func googleSignIn(_ sender: UIButton) {
        authViewModel.signIn(type: .google)
    }

    @objc func showSignupViewController(_ sender: UIButton) {
        present(RegistrationViewController(authViewModel: authViewModel), animated: true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
