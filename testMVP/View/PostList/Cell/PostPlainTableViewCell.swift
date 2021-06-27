//
//  PostPlainTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit

class PostPlainTableViewCell: PostTableViewCell {
    
    lazy var imageContentConstraints: [NSLayoutConstraint] = {
        let imageRightConstraint: NSLayoutConstraint = contentImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor)
        imageRightConstraint.priority = UILayoutPriority(rawValue: 999)
        
        let constraints: [NSLayoutConstraint] = [
            contentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            contentImageView.heightAnchor.constraint(equalToConstant: 200),
            contentImageView.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            imageRightConstraint,
            contentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var secondImageContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            secondContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            secondContentImageView.leftAnchor.constraint(equalTo: contentImageView.rightAnchor, constant: 12),
            secondContentImageView.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            secondContentImageView.widthAnchor.constraint(equalTo: contentImageView.widthAnchor),
            secondContentImageView.heightAnchor.constraint(equalTo: contentImageView.heightAnchor),
            secondContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()
    
    lazy var gifContentConstraints: [NSLayoutConstraint] = {
        let constraints: [NSLayoutConstraint] = [
            gifContentImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            gifContentImageView.centerXAnchor.constraint(equalTo: postContentView.centerXAnchor),
            gifContentImageView.heightAnchor.constraint(equalToConstant: 200),
            gifContentImageView.widthAnchor.constraint(equalTo: gifContentImageView.heightAnchor),
            gifContentImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
        ]
        return constraints
    }()

//    MARK: - Properties
    let contentImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let secondContentImageView: CustomImageView = {
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
    
//    MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentImageView.image = nil
        secondContentImageView.image = nil
        gifContentImageView.image = nil
        
        contentImageView.removeFromSuperview()
        secondContentImageView.removeFromSuperview()
        gifContentImageView.removeFromSuperview()
    }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        
        contentImageView.setImage(data.imageContentURL) { [weak self] succeeded in
            guard let self = self, succeeded else { return }
            
            self.secondContentImageView.setImage(data.secondImageContentURL) { [weak self] succeeded in
                guard let self = self else { return }
                guard succeeded else {
                    guard self.tag == self.indexPath.row else {
                        return self.contentImageView.image = nil
                    }
                    self.postContentView.addSubview(self.contentImageView)
                    NSLayoutConstraint.activate(self.imageContentConstraints)
                    return
                }
                
                guard self.tag == self.indexPath.row else {
                    self.contentImageView.image = nil
                    self.secondContentImageView.image = nil
                    return
                }
                self.postContentView.addSubview(self.contentImageView)
                self.postContentView.addSubview(self.secondContentImageView)
                NSLayoutConstraint.activate(self.imageContentConstraints)
                NSLayoutConstraint.activate(self.secondImageContentConstraints)
            }
        }
        
        gifContentImageView.setImage(data.imageGifContentURL) { [weak self] succeeded in
            guard let self = self, succeeded else { return }
            guard self.tag == self.indexPath.row else {
                return self.gifContentImageView.image = nil
            }
            
            self.postContentView.addSubview(self.gifContentImageView)
            NSLayoutConstraint.activate(self.gifContentConstraints)
        }
    }
}
