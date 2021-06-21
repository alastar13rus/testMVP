//
//  PostDetailAudioCoverView.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 21.06.2021.
//

import UIKit
import AVFoundation

class PostDetailAudioCoverView: PostDetailContentView {
    
    //    MARK: - Properties
    var player: AVPlayer!
    
    let audioCoverImageView: UIImageView = {
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
        button.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        button.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        button.addTarget(self, action: #selector(handlePlayVideo(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
        
        
//    MARK: - Methods
    override func configure(with data: PostDetailData) {
        super.configure(with: data)
        
        if let url = data.imageContentURL {
            url.downloadImageData { [weak self] (imageData) in
                guard let self = self, let imageData = imageData else { return }
                self.audioCoverImageView.image = UIImage(data: imageData)
            }
        }
        
        setupPlayer(with: data)
        setupSlider(with: data)
    }
    
    override func setupHierarhy() {
        super.setupHierarhy()
        
        postContentView.addSubview(audioCoverImageView)
        postContentView.addSubview(slider)
        postContentView.addSubview(playButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        NSLayoutConstraint.activate([
            audioCoverImageView.topAnchor.constraint(equalTo: postContentView.topAnchor),
            audioCoverImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            audioCoverImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            
            playButton.centerXAnchor.constraint(equalTo: audioCoverImageView.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: audioCoverImageView.centerYAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 48),
            playButton.heightAnchor.constraint(equalTo: playButton.widthAnchor),
            
            slider.topAnchor.constraint(equalTo: audioCoverImageView.bottomAnchor, constant: 12),
            slider.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            slider.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            slider.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
            slider.heightAnchor.constraint(equalToConstant: 48),
            
            
        ])
    }
    
    @objc private func handlePlayVideo(_ sender: UIButton) {
        guard let player = self.player else { return }
        switch player.timeControlStatus {
        case .playing:
            player.pause()
            playButton.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        case .paused:
            player.play()
            playButton.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
            
        default: break
        }
        
    }
    
    private func setupPlayer(with data: PostDetailData) {
        guard let url = data.audioContent?.url else { return }
        let player = AVPlayer(url: url)
        player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.01, preferredTimescale: 1000), queue: DispatchQueue.main) { (time) in
            self.slider.value = Float(time.seconds)
        }
        
        self.player = player
    }
    
    private func setupSlider(with data: PostDetailData) {
        
        self.slider.maximumValue = Float(player.currentItem?.asset.duration.seconds ?? 0)
    }
}
