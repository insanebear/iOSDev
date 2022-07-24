//
//  AuthenticationViewModel.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/12.
//

import Foundation
import FirebaseAuth

final class AuthenticationViewModel {
    var state: State
    var authenticationType: AuthenticationType
    var userInfo: UserInfo?
    
    private var authenticator: Authenticator {
        return Authenticator(authViewModel: self)
    }
    
    init() {
        if let user = Auth.auth().currentUser {
            self.state = .signedIn(user)
        } else {
            self.state = .signedOut
        }
        
        authenticationType = .none
    }
    
    func signIn(type: AuthenticationType, email: String? = nil, password: String? = nil) {
        switch type {
        case .email:
            if let email = email, let password = password {
                authenticationType = .email
                authenticator.emailSignIn(email: email, password: password)
            }
        case .google:
            authenticationType = .google
            authenticator.googleSignIn()
        default:
            break
        }
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
        case signedIn(User)
        case signedOut
    }
    
    enum AuthenticationType {
        case none
        case email
        case google
    }
}
