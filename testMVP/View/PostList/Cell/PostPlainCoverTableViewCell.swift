//
//  PostPlainCoverTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit

class PostPlainCoverTableViewCell: PostTableViewCell {
    
    lazy var imageGifContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            imageGifContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            imageGifContentImageView.centerXAnchor.constraint(equalTo: postContentView.centerXAnchor),
            imageGifContentImageView.heightAnchor.constraint(equalToConstant: 100),
            imageGifContentImageView.widthAnchor.constraint(equalTo: imageGifContentImageView.heightAnchor),
            imageGifContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()

//    MARK: - Properties
    let imageGifContentImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
//    MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        imageGifContentImageView.image = nil
        imageGifContentImageView.removeFromSuperview()
    }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        if let url = data.imageGifContentURL {
            url.downloadImageData { [weak self] (imageData) in
                guard let self = self, let imageData = imageData else { return }
                self.imageGifContentImageView.image = UIImage(data: imageData)
            }
            postContentView.addSubview(imageGifContentImageView)
            NSLayoutConstraint.activate(imageGifContentConstraints)
        }
        
    }
}
