//
//  GoogleSignInAuthenticator.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/12.
//

import Foundation
import GoogleSignIn
import UIKit

final class GoogleSignInAuthenticator {
    private var configuration: GIDConfiguration = {
        guard let clientID = Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String else {
            fatalError()
        }
        return GIDConfiguration(clientID: clientID)
    } ()
    
    private var authViewModel: AuthenticationViewModel
    
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    
    func signIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }
        
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { user, error in
            guard let user = user else {
                print("Error! \(String(describing: error))")
                return
            }
            
            self.authViewModel.state = .signedIn(user)
            
            let viewController = ViewController(authViewModel: self.authViewModel)
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            
            rootViewController.present(viewController, animated: true) {
                print("Login succeeded")
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        authViewModel.state = .signedOut
    }
    
    func disconnect() {
        GIDSignIn.sharedInstance.disconnect { error in
            if let error = error {
                print("Encountered error disconnecting scope: \(error)")
            }
            self.signOut()
        }
    }
}
