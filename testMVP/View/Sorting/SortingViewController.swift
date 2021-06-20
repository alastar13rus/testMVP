//
//  SortingViewController.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import UIKit

protocol SortingView: class {
    
    func updateData()
    
}

class SortingViewController: UIViewController {
    
//    MARK: - Properties
    var presenter: SortingPresenterProtocol! {
        didSet {
            presenter.showSortingItemsTrigger()
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.allowsMultipleSelection = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SortingTableViewCell.self, forCellReuseIdentifier: String(describing: SortingTableViewCell.self))
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
        navigationItem.title = "Выбор сортировки"
        view.backgroundColor = .white
        self.navigationController?.isToolbarHidden = false
    }
    
    private func setupHierarhy() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
    }
    
    
}

extension SortingViewController: SortingView {
    
    func updateData() {
        tableView.reloadData()
    }
    
}

extension SortingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.sortingItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SortingTableViewCell.self)) as? SortingTableViewCell else { return UITableViewCell() }
        
        cell.data = presenter.sortingItems[indexPath.row]
        return cell
    }
    
}

extension SortingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = presenter.sortingItems[indexPath.row]
        presenter.saveSelectedSortingByIndexTrigger(selectedItem)
    }
}


