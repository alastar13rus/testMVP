//
//  PostTableViewCell.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 16.06.2021.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
//    MARK: - Properties
    var postData: PostData! {
        didSet {
            configure(with: postData)
        }
    }
    
    let postHeaderView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemRed
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postContentView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemBlue
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postFooterView: UIView = {
        let view = UIView()
//        view.backgroundColor = .systemYellow
//        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.startAnimating()
        activity.hidesWhenStopped = true
        activity.color = .systemBlue
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    let authorImageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 10
        iv.clipsToBounds = true
//        iv.backgroundColor = .systemGray5
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let textContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
//        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updatedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.textColor = .secondaryLabel
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .systemGray2
        label.textColor = .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let isMyFavoriteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postContents: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupHierarhy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        authorImageView.image = nil
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }
    
    
//    MARK: - Methods
    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        accessoryType = .disclosureIndicator
        setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setupHierarhy() {
        contentView.addSubview(postHeaderView)
        contentView.addSubview(postContentView)
        contentView.addSubview(postFooterView)
        
        postHeaderView.addSubview(authorNameLabel)
        postHeaderView.addSubview(activityIndicator)
        postHeaderView.addSubview(authorImageView)

        postContentView.addSubview(textContentLabel)

//        postContentView.addSubview(postTypeLabel)
//        postContentView.addSubview(postContents)
//
        postFooterView.addSubview(createdAtLabel)
        postFooterView.addSubview(updatedAtLabel)
        postFooterView.addSubview(tagsLabel)
    }
    
    func setupConstraints(_ data: PostData) {
        
        let createdAtLabelTopConstraint: NSLayoutConstraint = createdAtLabel.topAnchor.constraint(equalTo: postFooterView.topAnchor)
        createdAtLabelTopConstraint.priority = .defaultLow
        
        let textContentLabelBottomConstraint = textContentLabel.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor)
        textContentLabelBottomConstraint.priority = .defaultLow

        NSLayoutConstraint.activate([
            postHeaderView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 12),
            postHeaderView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
            postHeaderView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -12),
            
            postContentView.topAnchor.constraint(equalTo: postHeaderView.bottomAnchor, constant: 12),
            postContentView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
            postContentView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -12),
            
//            postFooterView.topAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: 12),
            postFooterView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
            postFooterView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -12),
            postFooterView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
            activityIndicator.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            activityIndicator.leftAnchor.constraint(equalTo: postHeaderView.leftAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: CGFloat(data.cellHeaderHeight)),
            activityIndicator.heightAnchor.constraint(equalTo: authorImageView.widthAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),
            
            authorImageView.topAnchor.constraint(equalTo: postHeaderView.topAnchor),
            authorImageView.leftAnchor.constraint(equalTo: postHeaderView.leftAnchor),
            authorImageView.widthAnchor.constraint(equalToConstant: CGFloat(data.cellHeaderHeight)),
            authorImageView.heightAnchor.constraint(equalTo: authorImageView.widthAnchor),
            authorImageView.bottomAnchor.constraint(equalTo: postHeaderView.bottomAnchor),

            authorNameLabel.topAnchor.constraint(equalTo: authorImageView.topAnchor),
            authorNameLabel.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: 12),
            authorNameLabel.rightAnchor.constraint(equalTo: postHeaderView.rightAnchor),
            
            textContentLabel.topAnchor.constraint(equalTo: postContentView.topAnchor),
            textContentLabel.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            textContentLabel.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            textContentLabelBottomConstraint,
            
            createdAtLabelTopConstraint,
            createdAtLabel.rightAnchor.constraint(equalTo: postFooterView.rightAnchor),

            updatedAtLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor),
            updatedAtLabel.rightAnchor.constraint(equalTo: postFooterView.rightAnchor),
            updatedAtLabel.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor),
            
            tagsLabel.bottomAnchor.constraint(equalTo: postFooterView.bottomAnchor),
            tagsLabel.leftAnchor.constraint(equalTo: postFooterView.leftAnchor),
            
//
//
//            postTypeLabel.topAnchor.constraint(equalTo: isMyFavoriteLabel.bottomAnchor),
//            postTypeLabel.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
//
//            postContents.topAnchor.constraint(equalTo: postTypeLabel.bottomAnchor),
//            postContents.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
        ])
    }
    
    func configure(with data: PostData) {
        
        setupConstraints(data)
        
        authorNameLabel.text = data.authorName
        textContentLabel.text = data.textContent
        createdAtLabel.text = data.createdAtString
        updatedAtLabel.text = data.updatedAtString
        tagsLabel.text = data.tagsContent
        isMyFavoriteLabel.text = data.isMyFavorite ? "yes" : "no"
        postTypeLabel.text = data.typeString
        postContents.text = data.contentsString
        
        if let url = data.imageContentURL {
            
            url.downloadImageData { [weak self] (imageData) in
                
                guard let self = self else { return }
                self.activityIndicator.stopAnimating()
                
                guard let imageData = imageData else {
                    self.authorImageView.image = data.authorGender.getImage()
                    return
                }
                
                self.authorImageView.image = UIImage(data: imageData)
            }
        } else {

            self.activityIndicator.stopAnimating()
            authorImageView.image = data.authorGender.getImage()
        }
    }
}
