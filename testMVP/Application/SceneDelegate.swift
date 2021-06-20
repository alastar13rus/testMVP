//
//  SceneDelegate.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 15.06.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        guard let window = window else { return }
        
        let navigationController = UINavigationController()
        let router = PostListRouter(navigationController: navigationController)
        let (viewController, _) = router.buildPostListBundle()
        navigationController.viewControllers = [viewController]
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }


}

