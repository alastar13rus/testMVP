//
//  PostDetailPlainView.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 21.06.2021.
//

import UIKit

class PostDetailPlainView: PostDetailContentView {
    
//    MARK: - Properties
        
    lazy var imageContentConstraints: [NSLayoutConstraint] = {
        let imageRightConstraint: NSLayoutConstraint = imageContentImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor)
        imageRightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        let constraints: [NSLayoutConstraint] = [
            imageContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            imageContentImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            imageRightConstraint,
            imageContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var secondImageContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            secondImageContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            secondImageContentImageView.leftAnchor.constraint(equalTo: imageContentImageView.rightAnchor, constant: 12),
            secondImageContentImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            secondImageContentImageView.widthAnchor.constraint(equalTo: imageContentImageView.widthAnchor),
            secondImageContentImageView.heightAnchor.constraint(equalTo: imageContentImageView.heightAnchor),
            secondImageContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var imageGifContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            imageGifContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            imageGifContentImageView.centerXAnchor.constraint(equalTo: postContentView.centerXAnchor),
            imageGifContentImageView.widthAnchor.constraint(equalTo: imageGifContentImageView.heightAnchor),
            imageGifContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    let imageContentImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
//        iv.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
//        iv.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let secondImageContentImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
//        iv.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
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
    
    
        
        
//    MARK: - Methods
    
    override func configure(with data: PostDetailData) {
        super.configure(with: data)
        
        
        imageContentImageView.setImage(with: data.imageContentURL) { [weak self] (isSuccess) in
            guard let self = self, isSuccess else { return }
            
            
            self.secondImageContentImageView.setImage(with: data.secondImageContentURL) { [weak self] (isSuccess) in
                guard let self = self else { return }
                if isSuccess {
                    self.postContentView.addSubview(self.imageContentImageView)
                    self.postContentView.addSubview(self.secondImageContentImageView)
                    NSLayoutConstraint.activate(self.imageContentConstraints)
                    NSLayoutConstraint.activate(self.secondImageContentConstraints)
                } else {
                    self.postContentView.addSubview(self.imageContentImageView)
                    NSLayoutConstraint.activate(self.imageContentConstraints)
                }
            }
        }
        
        imageGifContentImageView.setImage(with: data.imageGifContentURL) { [weak self] (isSuccess) in
            guard let self = self, isSuccess else { return }
            self.postContentView.addSubview(self.imageGifContentImageView)
            NSLayoutConstraint.activate(self.imageGifContentConstraints)
        }
    }
}
