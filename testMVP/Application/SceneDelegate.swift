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
        
        let router = PostListRouter()
        let viewController = router.buildPostListBundle().vc
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }


}

