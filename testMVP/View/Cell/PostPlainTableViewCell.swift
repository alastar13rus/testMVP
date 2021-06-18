//
//  PostPlainTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit

class PostPlainTableViewCell: PostTableViewCell {
    
    lazy var imageContentConstraints: [NSLayoutConstraint] = {
        let imageRightConstraint: NSLayoutConstraint = imageContentImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor)
        imageRightConstraint.priority = .defaultLow
        
        let constraints: [NSLayoutConstraint] = [
            imageContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            imageContentImageView.heightAnchor.constraint(equalToConstant: 100),
            imageContentImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            imageRightConstraint,
            imageContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var secondImageContentConstraints: [NSLayoutConstraint] = {
        let secondImageWidthConstraint: NSLayoutConstraint = secondImageContentImageView.widthAnchor.constraint(equalTo: imageContentImageView.widthAnchor)
        secondImageWidthConstraint.priority = .defaultHigh
        let constraints: [NSLayoutConstraint] = [
            secondImageContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            secondImageContentImageView.leftAnchor.constraint(equalTo: imageContentImageView.rightAnchor, constant: 12),
            secondImageContentImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            secondImageWidthConstraint,
            secondImageContentImageView.heightAnchor.constraint(equalTo: imageContentImageView.heightAnchor),
            secondImageContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
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
    let imageContentImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let secondImageContentImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
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
        
        imageContentImageView.image = nil
        secondImageContentImageView.image = nil
        imageGifContentImageView.image = nil
        
//        NSLayoutConstraint.deactivate(imageContentConstraints)
//        NSLayoutConstraint.deactivate(secondImageContentConstraints)
//        NSLayoutConstraint.deactivate(imageGifContentConstraints)
        
        imageContentImageView.removeFromSuperview()
        secondImageContentImageView.removeFromSuperview()
        imageGifContentImageView.removeFromSuperview()
    }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        if let url = data.imageContentURL {
            url.downloadImageData { [weak self] (imageData) in
                guard let self = self, let imageData = imageData else { return }
                self.imageContentImageView.image = UIImage(data: imageData)
            }
            postContentView.addSubview(imageContentImageView)
            NSLayoutConstraint.activate(imageContentConstraints)
        }
        
        if let url = data.secondImageContentURL {
            url.downloadImageData { [weak self] (imageData) in
                guard let self = self, let imageData = imageData else { return }
                self.secondImageContentImageView.image = UIImage(data: imageData)
            }
            postContentView.addSubview(secondImageContentImageView)
            NSLayoutConstraint.activate(secondImageContentConstraints)
        }
        
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
