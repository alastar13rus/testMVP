//
//  PostListTableView.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 18.06.2021.
//

import UIKit

class PostListTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.tableFooterView = UIView()
        self.separatorColor = .systemBlue
        self.separatorInset = .init(top: 12, left: 12, bottom: 12, right: 12)
        self.register(PostTableViewCell.self, forCellReuseIdentifier: String(describing: PostTableViewCell.self))
        self.register(PostPlainTableViewCell.self, forCellReuseIdentifier: String(describing: PostPlainTableViewCell.self))
        self.register(PostPlainCoverTableViewCell.self, forCellReuseIdentifier: String(describing: PostPlainCoverTableViewCell.self))
        self.register(PostAudioCoverTableViewCell.self, forCellReuseIdentifier: String(describing: PostAudioCoverTableViewCell.self))
        self.register(PostVideoTableViewCell.self, forCellReuseIdentifier: String(describing: PostVideoTableViewCell.self))
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
