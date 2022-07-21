//
//  SceneDelegate.swift
//  SocialSigninProject
//
//  Created by Jayde Jeong on 2022/07/11.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.makeKeyAndVisible()
        
        // Restore user login status
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            let authViewModel = AuthenticationViewModel()
            if let user = user, let profile = user.profile {
                // Show the app's signed-in state.
                // ???: Can use a function for Firebase authentication from GoogleSignInAuthenticator?
                authViewModel.state = .signedIn(user)
                authViewModel.user = User(email: profile.email,
                                          name: profile.name,
                                          profileImage: profile.imageURL(withDimension: UInt(45 * UIScreen.main.scale)))

                // Firebase authentication
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
                    
                    self.window?.rootViewController = MainViewController(authViewModel: authViewModel)
                }
            } else if error != nil || user == nil {
                // Show the app's signed-out state.
                authViewModel.state = .signedOut
                self.window?.rootViewController = LoginViewController(authViewModel: authViewModel)
            } else {
                authViewModel.state = .signedOut
                print("Error occurred as restoring the previous sign-in: \(String(describing: error))")
            }
        }
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

