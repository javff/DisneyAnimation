//
//  SceneDelegate.swift
//  DisneyAnimation
//
//  Created by Juan vasquez on 02-05-22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        let disneyCastleTheme = Theme(name: "Splash", withCastle: true)
        let disneyController = DisneySplashScreenViewController(theme: disneyCastleTheme, duration: 8)
        disneyController.delegate = self
        window?.rootViewController = disneyController
        window?.makeKeyAndVisible()
    }

}

extension SceneDelegate: DisneySplashControllerDelegate {

    func splashController(_ controller: DisneySplashScreenViewController, finished: Bool) {
        guard finished else { return }
        showRootViewController()
    }

    private func showRootViewController() {
        guard let window = window else { return }
        let navigationController = UINavigationController(rootViewController: PrincipalViewController())
        window.rootViewController = navigationController
        let options: UIView.AnimationOptions = .transitionCrossDissolve
        let duration: TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil)
    }
}

