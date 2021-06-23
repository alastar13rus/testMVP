//
//  PostListViewController.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 15.06.2021.
//

import UIKit

protocol PostListView: class {
    
    func updateData()
    func updatePartialData(newList: [PostData], oldList: [PostData])
    func updateSortingName()
    func updateFetchingStatus(_ status: Bool)

}

class PostListViewController: UIViewController, PostListView {
    
//    MARK: - Properties
    var presenter: PostListPresenterProtocol!
    
    lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        refresh.translatesAutoresizingMaskIntoConstraints = false
        return refresh
    }()
    
    lazy var tableView: PostListTableView = {
        let tableView = PostListTableView()
        tableView.refreshControl = refreshControl
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.didFirstPageTriggerFired()
    }

    
//    MARK: - Methods
    private func setupUI() {
        setupNavigation()
        view.backgroundColor = .white
    }
    
    private func setupNavigation() {
        navigationItem.title = "Список постов"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "sort"), style: .plain, target: self, action: #selector(sortingSettingsButtonPressed(_:)))
    }

    private func setupHierarhy() {
        view.addSubview(tableView)
        view.addSubview(activityIndicator)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            
                activityIndicator.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
        ])
    }
    
    func updateData() {
        print(#function)
        refreshControl.endRefreshing()
        tableView.reloadData()
        tableViewBackgroundView()
    }
    
    private func tableViewBackgroundView() {
        
        let tableViewBackgroundView: UIView = {
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: tableView.bounds.height)))
            let textLabel = UILabel()
            textLabel.textColor = .secondaryLabel
            textLabel.text = "Записей не найдено..."
            textLabel.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
            let textWidth = textLabel.intrinsicContentSize.width
            let textHeight = textLabel.intrinsicContentSize.height

            textLabel.frame = CGRect(x: view.bounds.midX - textWidth / 2,
                                     y: view.bounds.midY - textHeight / 2,
                                     width: textWidth,
                                     height: textHeight)
                
            view.addSubview(textLabel)
            return view
        }()
        
        tableView.backgroundView = presenter.posts.isEmpty ? tableViewBackgroundView : nil
    }
    
    func updatePartialData(newList: [PostData], oldList: [PostData]) {
        refreshControl.endRefreshing()
        tableView.reloadDataWithAnimation(newList: newList, oldList: oldList)
        updateSortingName()
    }
    
    func updateSortingName() {
        tableView.tableHeaderView = {
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: tableView.bounds.width, height: 48)))
            let textLabel = UILabel()
            view.backgroundColor = .systemGray5
            view.addSubview(textLabel)
            textLabel.text = presenter.sortingName
            textLabel.frame = view.bounds
            return view
        }()
    }
    
    func updateFetchingStatus(_ status: Bool) {
        status ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }

    @objc private func handleRefresh(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        presenter.didRefreshTriggerFired()
    }
    
    @objc private func sortingSettingsButtonPressed(_ sender: UIBarButtonItem) {
        presenter.presentSortingSettings()
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
            cell.indexPath = indexPath
            cell.tag = indexPath.row
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .plainCover:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostPlainCoverTableViewCell.self)) as? PostPlainCoverTableViewCell else { return UITableViewCell() }
            cell.indexPath = indexPath
            cell.tag = indexPath.row
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .audioCover:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostAudioCoverTableViewCell.self)) as? PostAudioCoverTableViewCell else { return UITableViewCell() }
            cell.indexPath = indexPath
            cell.tag = indexPath.row
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        case .video:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostVideoTableViewCell.self)) as? PostVideoTableViewCell else { return UITableViewCell() }
            cell.indexPath = indexPath
            cell.tag = indexPath.row
            cell.postData = presenter.posts[indexPath.row]
            return cell
            
        }
    }
}

extension PostListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = presenter.posts[indexPath.row]
        
        var textHeight: CGFloat = 0
        if let textContent = item.textContent {
            textHeight = tableView.calculateTextLabelHeight(withContent: textContent, font: UIFont.systemFont(ofSize: 14))
        }
        return textHeight + CGFloat(item.cellHeaderHeight + item.cellContentHeight + item.cellFooterHeight + item.cellPaddings)

    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.posts.count - 1 {
            presenter.didNextPageTriggerFired()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postData = presenter.posts[indexPath.row]
        presenter.didSelectItemTrigger(postData)
        
        
    }
    
}
