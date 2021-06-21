//
//  PostDetailViewController.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 20.06.2021.
//

import UIKit

protocol PostDetailView: class {
 
    func updateData(with data: PostDetailData)
    
}

class PostDetailViewController: UIViewController {
    
//    MARK: - Properties
    var presenter: PostDetailPresenter!
    var contentView: PostDetailContentView!
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        if let contentView = contentView as? PostDetailVideoView,
//           let avPlayerLayer = contentView.videoPlayerView.layer.sublayers?.first {
//            print(contentView.videoPlayerView.layer)
//            avPlayerLayer.frame = contentView.videoPlayerView.bounds
//        }
//    }
    
    
//    MARK: - Methods
    private func setupUI(with data: PostDetailData) {
        view.backgroundColor = .white
        navigationItem.title = data.typeString
    }
    
    private func setupHierarhy(with data: PostDetailData) {
        switch data.type {
        case .plain, .plainCover:
            self.contentView = PostDetailPlainView()
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            guard let contentView = self.contentView as? PostDetailPlainView else { return }
            view.addSubview(contentView)
        case .video:
            self.contentView = PostDetailVideoView()
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            guard let contentView = self.contentView as? PostDetailVideoView else { return }
            view.addSubview(contentView)
        case .audioCover:
            self.contentView = PostDetailAudioCoverView()
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            guard let contentView = self.contentView as? PostDetailAudioCoverView else { return }
            view.addSubview(contentView)
        }
    }
    
    private func setupConstraints(with data: PostDetailData) {
        
//        guard let contentView = contentView else { return }
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            contentView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 12),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -12),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -12),
        ])
        
    }
    
    
}

extension PostDetailViewController: PostDetailView {
    
    func updateData(with data: PostDetailData) {
        setupUI(with: data)
        setupHierarhy(with: data)
        setupConstraints(with: data)
        
//        guard let contentView = contentView else { return }
        contentView.configure(with: data)
    }
    
    
    
}
