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
    let coverImageView: UIImageView = {
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
            
            coverImageView.image = nil
//            coverImageView.removeFromSuperview()
//            durationLabel.removeFromSuperview()
        }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        
        setupConstraints(data)
        
        durationLabel.text = data.audioContent?.duration ?? ""
        if let url = data.imageContentURL {
            url.downloadImageData { [weak self] (imageData) in
                guard let self = self, let imageData = imageData else { return }
                self.coverImageView.image = UIImage(data: imageData)
            }
        }
    }
    
    override func setupHierarhy() {
        super.setupHierarhy()
        
        postContentView.addSubview(coverImageView)
        coverImageView.addSubview(durationLabel)
    }
    
    override func setupConstraints(_ data: PostData) {
        super.setupConstraints(data)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            coverImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 12),
            coverImageView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -12),
            coverImageView.heightAnchor.constraint(equalToConstant: 100),
            coverImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
            
            durationLabel.centerXAnchor.constraint(equalTo: coverImageView.centerXAnchor),
            durationLabel.centerYAnchor.constraint(equalTo: coverImageView.centerYAnchor),
            
        ])
    }
    
}
