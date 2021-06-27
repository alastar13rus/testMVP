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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
//        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentMode = .scaleAspectFill
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    
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
        view.addSubview(scrollView)
        switch data.type {
        case .plain, .plainCover:
            self.contentView = PostDetailPlainView()
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            guard let contentView = self.contentView as? PostDetailPlainView else { return }
            scrollView.addSubview(contentView)
        case .video:
            self.contentView = PostDetailVideoView()
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            guard let contentView = self.contentView as? PostDetailVideoView else { return }
            scrollView.addSubview(contentView)
        case .audioCover:
            self.contentView = PostDetailAudioCoverView()
            self.contentView.translatesAutoresizingMaskIntoConstraints = false
            guard let contentView = self.contentView as? PostDetailAudioCoverView else { return }
            scrollView.addSubview(contentView)
        }
    }
    
    private func setupConstraints(with data: PostDetailData) {
        
//        guard let contentView = contentView else { return }
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 12),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -12),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -12),
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

extension PostDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentSize, scrollView.contentSize)
//        print("scrollView.contentOffset", scrollView.contentOffset)
//        print("scrollView.frame.size", scrollView.frame.size)
//        print("scrollView.bounds.size", scrollView.bounds.size)
        
        
    }
    
}
