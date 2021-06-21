//
//  PostDetailVideoView.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 21.06.2021.
//

import UIKit
import AVKit

class PostDetailVideoView: PostDetailContentView {
    
//    MARK: - Properties
    var playerVC: AVPlayerViewController!
    var player: AVPlayer!
//    var videoPlayerView: UIView!
    
    let previewImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .systemGray5
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 10
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    lazy var playButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 24
        button.backgroundColor = .black
        button.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(#imageLiteral(resourceName: "play").withTintColor(.white), for: .normal)
        button.addTarget(self, action: #selector(handlePlayVideo(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
//    MARK: - Methods
    override func configure(with data: PostDetailData) {
        super.configure(with: data)
        
        if let url = data.videoContent?.previewImageURL {
            url.downloadImageData { [weak self] (imageData) in
                guard let self = self, let imageData = imageData else { return }
                self.previewImageView.image = UIImage(data: imageData)
            }
        }
        
        setupPlayer(with: data)
        setupPlayerVC(player)
    }
    
    override func setupHierarhy() {
        super.setupHierarhy()
        
        postContentView.addSubview(previewImageView)
        postContentView.addSubview(playButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: postContentView.topAnchor),
            previewImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            previewImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            previewImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
            
            playButton.centerXAnchor.constraint(equalTo: postContentView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: postContentView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 48),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            
        ])
    }
    
    @objc private func handlePlayVideo(_ sender: UIButton) {
        print("play video")
        parentViewController?.present(playerVC, animated: true, completion: nil)
        playerVC.player?.play()
    }
    
    private func setupPlayer(with data: PostDetailData) {
        guard let url = data.videoContent?.url else { return }
        self.player = AVPlayer(url: url)
    }
    
    private func setupPlayerVC(_ player: AVPlayer) {
        let playerVC = AVPlayerViewController()
        playerVC.player = player
        self.playerVC = playerVC
    }
}
