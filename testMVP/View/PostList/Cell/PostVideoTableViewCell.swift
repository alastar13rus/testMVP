//
//  PostVideoTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit
import AVKit

class PostVideoTableViewCell: PostTableViewCell {
    
//    MARK: - Properties
    let previewImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.masksToBounds = true
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let videoDurationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    override func prepareForReuse() {
        super.prepareForReuse()
        
        previewImageView.image = nil
    }
    
//    MARK: - Methods
    override func configure(with data: PostData) {
        super.configure(with: data)
        
        setupConstraints(data)
        
        videoDurationLabel.text = data.videoContent?.duration ?? ""
        
        previewImageView.setImage(data.videoContent?.previewImageURL) { [weak self] _ in
            guard let self = self else { return }
            guard self.tag != self.indexPath.row else { return }
            self.previewImageView.image = nil
        }
    }
    
    override func setupHierarhy() {
        super.setupHierarhy()
        
        postContentView.addSubview(previewImageView)
        previewImageView.addSubview(videoDurationLabel)
    }
    
    override func setupConstraints(_ data: PostData) {
        super.setupConstraints(data)
        
        NSLayoutConstraint.activate([
            previewImageView.topAnchor.constraint(equalTo: textContentLabel.bottomAnchor, constant: 12),
            previewImageView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
            previewImageView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -12),
            previewImageView.heightAnchor.constraint(equalToConstant: 200),
            previewImageView.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor),
            
            videoDurationLabel.centerXAnchor.constraint(equalTo: previewImageView.centerXAnchor),
            videoDurationLabel.centerYAnchor.constraint(equalTo: previewImageView.centerYAnchor),
            
        ])
    }
    
}
