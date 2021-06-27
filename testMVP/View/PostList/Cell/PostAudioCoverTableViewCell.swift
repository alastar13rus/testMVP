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
    let audioCoverImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let gifContentImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
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
    
//    MARK: - Constraints
    lazy var audioCoverImageViewConstraints: [NSLayoutConstraint] = [
        audioCoverImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
        audioCoverImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor, constant: 12),
        audioCoverImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor, constant: -12),
        audioCoverImageView.heightAnchor.constraint(equalToConstant: 200),
        audioCoverImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        
        durationLabel.centerXAnchor.constraint(equalTo: audioCoverImageView.centerXAnchor),
        durationLabel.centerYAnchor.constraint(equalTo: audioCoverImageView.centerYAnchor),
    ]
    
    lazy var gifContentImageViewConstraints: [NSLayoutConstraint] = [
        gifContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
        gifContentImageView.centerXAnchor.constraint(equalTo: postContentView.centerXAnchor),
        gifContentImageView.heightAnchor.constraint(equalToConstant: 200),
        gifContentImageView.widthAnchor.constraint(equalTo: gifContentImageView.heightAnchor),
        gifContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
    ]
    
//    MARK: - Init
        override func prepareForReuse() {
            super.prepareForReuse()
            
            audioCoverImageView.image = nil
            gifContentImageView.image = nil
            
            audioCoverImageView.removeFromSuperview()
            gifContentImageView.removeFromSuperview()

        }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        durationLabel.text = data.audioContent?.duration ?? ""
        
        audioCoverImageView.setImage(data.imageContentURL) { [ weak self] succeeded in
            guard let self = self, succeeded else { return }
            guard self.tag == self.indexPath.row else {
                return self.audioCoverImageView.image = nil
            }
            self.postContentView.addSubview(self.audioCoverImageView)
            self.audioCoverImageView.addSubview(self.durationLabel)
            NSLayoutConstraint.activate(self.audioCoverImageViewConstraints)
        }
        
        gifContentImageView.setImage(data.imageGifContentURL) { [ weak self] succeeded in
            guard let self = self, succeeded else { return }
            guard self.tag == self.indexPath.row else {
                return self.gifContentImageView.image = nil
            }
            self.postContentView.addSubview(self.gifContentImageView)
            NSLayoutConstraint.activate(self.gifContentImageViewConstraints)
        }
    }
}
