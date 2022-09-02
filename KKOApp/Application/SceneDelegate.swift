//
//  SceneDelegate.swift
//  KKOApp
//
//  Created by VironIT on 19.08.22.
//
import FirebaseAuth
import LocalAuthentication
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let passwordVC = PasswordVC(nibName: "Password", bundle: nil)
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let winScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: winScene)
        if FirebaseAuth.Auth.auth().currentUser != nil {
            toMainTabBar()
        } else {
            toLogIn()
        }
    }
    
    private func toMainTabBar() {
        let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
        let tabBarScreen = storyboard.instantiateViewController(withIdentifier: Screens.mainTabBar.rawValue)
        window!.rootViewController = tabBarScreen
        window!.makeKeyAndVisible()
    }
    
    private func toLogIn() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUpScreen = storyboard.instantiateViewController(withIdentifier: Screens.login.rawValue)
        window!.rootViewController = signUpScreen
        window!.makeKeyAndVisible()
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

//    func sceneWillEnterForeground(_ scene: UIScene) {
//        passwordVC.modalPresentationStyle = .overFullScreen
//        self.window?.rootViewController?.present(passwordVC, animated: true)
//        authorization()
//    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        func sceneDidEnterBackground(_ scene: UIScene) {
            self.passwordVC.dismiss(animated: true)
        }
    }
    
    private func authorization() {
        let context = LAContext()
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authorized") { success, error in
                if success {
                    DispatchQueue.main.async {
                        self.passwordVC.dismiss(animated: true)
                    }
                }
            }
        }
    }

}

