//
//  LoginViewController+Actions.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/24.
//

import UIKit

extension LoginViewController {
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
