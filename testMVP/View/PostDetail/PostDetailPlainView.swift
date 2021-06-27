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
        let imageBottomConstraint: NSLayoutConstraint = imageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor)
        imageBottomConstraint.priority = UILayoutPriority(rawValue: 999)
        
        let constraints: [NSLayoutConstraint] = [
            imageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            imageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            imageBottomConstraint,
        ]
        return constraints
    }()
    
    lazy var secondImageContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            secondImageView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            secondImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            secondImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            secondImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var gifContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            gifImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            gifImageView.centerXAnchor.constraint(equalTo: postContentView.centerXAnchor),
            gifImageView.widthAnchor.constraint(equalTo: gifImageView.heightAnchor),
            gifImageView.heightAnchor.constraint(equalToConstant: 200),
            gifImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var imageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let secondImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let gifImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
        
        
//    MARK: - Methods
    
    override func configure(with data: PostDetailData) {
        super.configure(with: data)
        
        
        imageView.setImage(data.imageContentURL) { [weak self] succeeded in
            guard let self = self, succeeded else { return }
            
            self.postContentView.addSubview(self.imageView)
            NSLayoutConstraint.activate(self.imageContentConstraints)
            let ratio = self.imageView.image!.size.height / self.imageView.image!.size.width
            self.imageView.heightAnchor.constraint(equalTo: self.imageView.widthAnchor, multiplier: ratio).isActive = true
            
            self.secondImageView.setImage(data.secondImageContentURL) { [weak self] succeeded in
                guard let self = self, succeeded else { return }
                
                self.postContentView.addSubview(self.secondImageView)
                NSLayoutConstraint.activate(self.secondImageContentConstraints)
                let ratio = self.secondImageView.image!.size.height / self.secondImageView.image!.size.width
                self.secondImageView.heightAnchor.constraint(equalTo: self.secondImageView.widthAnchor, multiplier: ratio).isActive = true
            }
        }
        
        gifImageView.setImage(data.imageGifContentURL) { [weak self] succeeded in
            guard let self = self, succeeded else { return }
            
            self.postContentView.addSubview(self.gifImageView)
            NSLayoutConstraint.activate(self.gifContentConstraints)
        }
    }
}
