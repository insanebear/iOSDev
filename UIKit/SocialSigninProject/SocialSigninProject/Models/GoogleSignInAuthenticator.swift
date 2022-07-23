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

final class GoogleSignInAuthenticator {
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
    
    func signIn() {
        guard let rootViewController = UIApplication.shared.windows.first?.rootViewController else {
            print("No root view controller")
            return
        }
        
        // Google Sign-in
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { user, error in
            
            guard let user = user, let profile = user.profile else {
                print("Error! \(String(describing: error))")
                return
            }
            self.authViewModel.state = .signedIn(user)
            self.authViewModel.user = User(email: profile.email,
                                      name: profile.name,
                                      profileImage: profile.imageURL(withDimension: UInt(45 * UIScreen.main.scale)))
            
            let authentication = user.authentication
            
            guard let idToken = authentication.idToken else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    print("Error! \(String(describing: error))")
                    return
                }
                // User is signed in
                let viewController = MainViewController(authViewModel: self.authViewModel)
                viewController.modalTransitionStyle = .crossDissolve
                viewController.modalPresentationStyle = .fullScreen
                
                rootViewController.present(viewController, animated: true) {
                    print("Login succeeded")
                }
            }
        }
    }
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance.signOut()
            authViewModel.state = .signedOut
            authViewModel.user = nil
            
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
            } else {
                GIDSignIn.sharedInstance.disconnect { error in
                    if let error = error {
                        print("Encountered error disconnecting scope: \(error)")
                    } else {
                        self.signOut()
                    }
                }
            }
        }
    }
}
