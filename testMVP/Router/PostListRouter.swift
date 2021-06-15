//
//  PostListRouter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit

class PostListRouter {
    
////    MARK: - Properties
//    let navigationController: UINavigationController
//    
////    MARK: - Init
//    init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
    
    func buildPostListBundle() -> (vc: PostListViewController, presenter: PostListPresenter) {
        let vc = PostListViewController()
        let networkProvider = NetworkProvider(networkAgent: NetworkAgent.shared)
        let presenter = PostListPresenter(useCaseProvider: networkProvider, delegate: vc)
        vc.presenter = presenter
        return (vc: vc, presenter: presenter)
    }
    
}
