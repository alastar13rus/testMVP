//
//  PostAudioCoverTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit
import AVKit

class PostAudioCoverTableViewCell: PostTableViewCell {
    
//    MARK: - Properties
    let audioCoverImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let durationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //    MARK: - Init
        override func prepareForReuse() {
            super.prepareForReuse()
            
            audioCoverImageView.image = nil
        }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        
        setupConstraints(data)
        
        durationLabel.text = data.audioContent?.duration ?? ""
        
        audioCoverImageView.setImage(with: data.imageContentURL)
    }
    
    override func setupHierarhy() {
        super.setupHierarhy()
        
        postContentView.addSubview(audioCoverImageView)
        audioCoverImageView.addSubview(durationLabel)
    }
    
    override func setupConstraints(_ data: PostData) {
        super.setupConstraints(data)
        
        NSLayoutConstraint.activate([
            
            audioCoverImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            audioCoverImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
            audioCoverImageView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -12),
            audioCoverImageView.heightAnchor.constraint(equalToConstant: 100),
            audioCoverImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
            
            durationLabel.centerXAnchor.constraint(equalTo: audioCoverImageView.centerXAnchor),
            durationLabel.centerYAnchor.constraint(equalTo: audioCoverImageView.centerYAnchor),
            
        ])
    }
    
}
