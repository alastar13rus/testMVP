//
//  PostListViewController.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 15.06.2021.
//

import UIKit

protocol PostListView: class {
    
    
    
}

class PostListViewController: UIViewController, PostListView {
    
//    MARK: - Properties
    var presenter: PostListPresenter!
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }

    
//    MARK: - Methods
    private func setupUI() {
        view.backgroundColor = .white
    }

    private func setupHierarhy() {
        
    }

    private func setupConstraints() {
        
    }

}

