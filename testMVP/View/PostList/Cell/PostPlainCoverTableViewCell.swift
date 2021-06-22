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
    }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        imageGifContentImageView.setImage(with: data.imageGifContentURL) { [weak self] (success) in
            if success {
                guard let self = self else { return }
                self.postContentView.addSubview(self.imageGifContentImageView)
                NSLayoutConstraint.activate(self.imageGifContentConstraints)
            }
        }
        
    }
}
