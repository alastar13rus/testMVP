//
//  PostListRouter.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit

protocol PostListRoutable: class {
    func toSortingScreen()
    func toPostDetailScreen(with detailID: String)
}

protocol PostListBuildable: class {
    func buildPostListBundle() -> (vc: PostListViewController, presenter: PostListPresenter)
    func buildSortingBundle() -> (vc: SortingViewController, presenter: SortingPresenter)
    func buildPostDetailBundle(with detailID: String) -> (vc: PostDetailViewController, presenter: PostDetailPresenter)
}

class PostListRouter: PostListRoutable, PostListBuildable {
    
//    MARK: - Properties
    let navigationController: UINavigationController
    
//    MARK: - Init
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func buildPostListBundle() -> (vc: PostListViewController, presenter: PostListPresenter) {
        let vc = PostListViewController()
        let networkProvider = NetworkProvider(networkAgent: NetworkAgent.shared)
        let userDefaultsProvider = UserDefaultsProvider.shared
        let presenter = PostListPresenter(useCaseProvider: networkProvider, sortingUseCaseProvider: userDefaultsProvider, delegate: vc)
        presenter.router = self
        vc.presenter = presenter
        return (vc: vc, presenter: presenter)
    }
    
    func buildSortingBundle() -> (vc: SortingViewController, presenter: SortingPresenter) {
        let vc = SortingViewController()
        let userDefaultsProvider = UserDefaultsProvider.shared
        let presenter = SortingPresenter(useCaseProvider: userDefaultsProvider, delegate: vc)
        presenter.router = self
        vc.presenter = presenter
        return (vc: vc, presenter: presenter)
    }
    
    func buildPostDetailBundle(with detailID: String) -> (vc: PostDetailViewController, presenter: PostDetailPresenter) {
        let vc = PostDetailViewController()
        let networkProvider = NetworkProvider(networkAgent: NetworkAgent.shared)
        let presenter = PostDetailPresenter(detailID: detailID, useCaseProvider: networkProvider, delegate: vc)
        presenter.router = self
        vc.presenter = presenter
        return (vc: vc, presenter: presenter)
    }
    
    func toSortingScreen() {
        let(vc, _) = buildSortingBundle()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toPostDetailScreen(with detailID: String) {
        let(vc, _) = buildPostDetailBundle(with: detailID)
        navigationController.pushViewController(vc, animated: true)
    }
    
}
