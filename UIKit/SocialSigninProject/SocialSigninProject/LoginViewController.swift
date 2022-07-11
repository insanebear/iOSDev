//
//  LoginViewController.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/11.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    let signinButton: GIDSignInButton = {
        let button = GIDSignInButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    
    var signInConfig: GIDConfiguration!

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else {
            fatalError()
        }
        
        signInConfig = GIDConfiguration(clientID: clientID)
        
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
        let viewController = ViewController()
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .fullScreen
        
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            self.present(viewController, animated: true) {
                print("Login succeeded")
            }
        }
    }
}
