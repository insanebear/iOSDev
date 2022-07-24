//
//  GoogleSignInAuthenticator.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/12.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

final class Authenticator {
    private var configuration: GIDConfiguration = {
        guard let clientID = FirebaseApp.app()?.options.clientID as? String else {
            fatalError()
        }
        return GIDConfiguration(clientID: clientID)
    } ()
    
    private var authViewModel: AuthenticationViewModel
    
    init(authViewModel: AuthenticationViewModel) {
        self.authViewModel = authViewModel
    }
    
    func googleSignIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }
        
        // Google Sign-in
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { user, error in
            // get google user credential using GIDSignIn
            
            guard let authentication = user?.authentication,
                  let idToken = authentication.idToken else {
                print("Error! \(String(describing: error))")
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                // get firebase user info using google user credential
                
                if let error = error {
                    print("Error! \(String(describing: error))")
                    return
                }
                // User is signed in
                guard let firebaseUser = authResult?.user else {
                    print("Error! \(String(describing: error))")
                    return
                }
                self.authViewModel.state = .signedIn(firebaseUser)
                self.authViewModel.userInfo = UserInfo(email: firebaseUser.email,
                                                       name: firebaseUser.displayName,
                                                       profileImage: firebaseUser.photoURL)
                
                let viewController = MainViewController(authViewModel: self.authViewModel)
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                
                rootViewController.present(viewController, animated: true) {
                    print("Login succeeded")
                }
            }
        }
    }
    
    func emailSignIn(email: String, password: String) {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                let alertDialog = UIAlertController(title: "Login failed", message: "Check your email and password again.", preferredStyle: .alert)
                let okay = UIAlertAction(title: "Close", style: .default) { action in
                    alertDialog.dismiss(animated: true)
                }
                alertDialog.addAction(okay)
                rootViewController.present(alertDialog, animated: true)
                print("Error! \(String(describing: error))")
                return
            }
            
            // User is signed in
            guard let firebaseUser = authResult?.user else {
                print("Error! \(String(describing: error))")
                return
            }
            self.authViewModel.state = .signedIn(firebaseUser)
            self.authViewModel.userInfo = UserInfo(email: firebaseUser.email,
                                                   name: firebaseUser.displayName,
                                                   profileImage: firebaseUser.photoURL)
            
            // User is signed in
            let viewController = MainViewController(authViewModel: self.authViewModel)
            viewController.modalTransitionStyle = .crossDissolve
            viewController.modalPresentationStyle = .fullScreen
            
            rootViewController.present(viewController, animated: true) {
                print("Login succeeded")
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance.signOut()
            authViewModel.state = .signedOut
            authViewModel.userInfo = nil
            authViewModel.authenticationType = .none
            
            UIApplication.shared.windows.first?.rootViewController = LoginViewController(authViewModel: self.authViewModel)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    func disconnect() {
        let firebaseAuth = Auth.auth()
        
        firebaseAuth.currentUser?.delete { error in
            if let error = error {
                print("Encountered error disconnecting scope: \(String(describing: error))")
            }
            
            let authenticationType = self.authViewModel.authenticationType
            if authenticationType == .google {
                GIDSignIn.sharedInstance.disconnect { error in
                    if let error = error {
                        print("Encountered error disconnecting scope: \(error)")
                    } else {
                        self.signOut()
                    }
                }
            } else {
                self.signOut()
            }
        }
    }
}
