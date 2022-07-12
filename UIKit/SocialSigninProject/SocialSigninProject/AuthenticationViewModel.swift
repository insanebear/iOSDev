//
//  AuthenticationViewModel.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/12.
//

import Foundation
import GoogleSignIn

final class AuthenticationViewModel {
    var state: State
    
    private var authenticator: GoogleSignInAuthenticator {
        return GoogleSignInAuthenticator(authViewModel: self)
    }
    
    init() {
        if let user = GIDSignIn.sharedInstance.currentUser {
            self.state = .signedIn(user)
        } else {
            self.state = .signedOut
        }
    }
    
    func signIn() {
        authenticator.signIn()
    }
    
    func signOut() {
        authenticator.signOut()
    }
    
    func disconnect() {
        authenticator.disconnect()
    }
}

extension AuthenticationViewModel {
    enum State {
        case signedIn(GIDGoogleUser)
        case signedOut
    }
}
