//
//  PostListViewController.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 15.06.2021.
//

import UIKit

protocol PostListView: class {
    
    func updateData()
    
}

class PostListViewController: UIViewController, PostListView {
    
//    MARK: - Properties
    var presenter: PostListPresenter!
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.separatorColor = .systemBlue
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        tableView.register(PostPlainTableViewCell.self, forCellReuseIdentifier: String(describing: PostPlainTableViewCell.self))
        tableView.register(PostAudioCoverTableViewCell.self, forCellReuseIdentifier: String(describing: PostAudioCoverTableViewCell.self))
        tableView.register(PostVideoTableViewCell.self, forCellReuseIdentifier: String(describing: PostVideoTableViewCell.self))
        tableView.register(PostImageTableViewCell.self, forCellReuseIdentifier: String(describing: PostImageTableViewCell.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
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
        presenter.didFetchTriggerFired()
    }

    private func setupHierarhy() {
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    func updateData() {
        tableView.reloadData()
    }

}

//  MARK: - extensions
extension PostListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.posts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = presenter.posts[indexPath.row].type
        
        switch cellType {
        case .plain:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostPlainTableViewCell.self)) as? PostPlainTableViewCell else { return UITableViewCell() }
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .plainCover:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostPlainCoverTableViewCell.self)) as? PostPlainCoverTableViewCell else { return UITableViewCell() }
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .audioCover:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostAudioCoverTableViewCell.self)) as? PostAudioCoverTableViewCell else { return UITableViewCell() }
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .image:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostImageTableViewCell.self)) as? PostImageTableViewCell else { return UITableViewCell() }
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .video:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostVideoTableViewCell.self)) as? PostVideoTableViewCell else { return UITableViewCell() }
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        }
        
    }
    
}

extension PostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = presenter.posts[indexPath.row]
        return CGFloat(
            item.cellHeaderHeight +
            item.cellContentHeight +
            item.cellFooterHeight +
            item.cellPaddings)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
