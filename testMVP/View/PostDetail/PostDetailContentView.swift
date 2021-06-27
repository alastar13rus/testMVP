//
//  PostDetailContentView.swift
//  testMVP
//
//  Created by Докин Андрей (IOS) on 21.06.2021.
//

import UIKit

class PostDetailContentView: UIView {
    
//    MARK: - Properties
    let authorContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let socialContentStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        stack.alignment = .center
        stack.layer.cornerRadius = 10
        stack.clipsToBounds = true
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let footerContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let authorImageView: CustomImageView = {
        let view = CustomImageView()
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.layer.borderWidth = 5
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let authorNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let textContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likeStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let shareStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let viewStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let commentStackView: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let likeCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let viewCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let commentCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let shareCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.text = "0"
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let viewButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "view"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let isFavoriteButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "favorite"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
//        label.backgroundColor = .systemPink
        label.text = "createdAt"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let updatedAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 16)
        label.textColor = .secondaryLabel
//        label.backgroundColor = .systemOrange
        label.text = "updatedAt"
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.backgroundColor = .systemGray2
        label.textColor = .white
        label.text = "tags"
//        label.backgroundColor = .systemPurple
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupHierarhy()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: Methods
    
    func configure(with data: PostDetailData) {
        
        authorNameLabel.text = data.authorName
        textContentLabel.text = data.textContent
        
        likeCountLabel.text = "\(data.stats.likes.count)"
        shareCountLabel.text = "\(data.stats.shares.count)"
        commentCountLabel.text = "\(data.stats.replies.count)"
        viewCountLabel.text = "\(data.stats.views.count)"
        
        if data.isMyFavorite {
            isFavoriteButton.setImage(#imageLiteral(resourceName: "favorite").withTintColor(.systemRed), for: .normal)
        }
        


        createdAtLabel.text = data.createdAtString
        updatedAtLabel.text = data.updatedAtString
        tagsLabel.text = data.tagsContent
        
        authorImageView.setImage(data.imageContentURL) { [weak self] succeeded in
            guard let self = self, !succeeded else { return }
            self.authorImageView.image = data.authorGender.getImage()
        }
    }
    
    func setupUI() {
        
    }
    
    func setupHierarhy() {
        addSubview(authorContentView)
        addSubview(postContentView)
        addSubview(socialContentStackView)
        addSubview(footerContentView)
        
        authorContentView.addSubview(authorImageView)
        authorContentView.addSubview(authorNameLabel)
        
        postContentView.addSubview(textContentLabel)
        
        socialContentStackView.addArrangedSubview(likeStackView)
        socialContentStackView.addArrangedSubview(viewStackView)
        socialContentStackView.addArrangedSubview(shareStackView)
        socialContentStackView.addArrangedSubview(commentStackView)
        socialContentStackView.addArrangedSubview(isFavoriteButton)
        
        likeStackView.addArrangedSubview(likeButton)
        likeStackView.addArrangedSubview(likeCountLabel)
        
        shareStackView.addArrangedSubview(shareButton)
        shareStackView.addArrangedSubview(shareCountLabel)
        
        viewStackView.addArrangedSubview(viewButton)
        viewStackView.addArrangedSubview(viewCountLabel)
        
        commentStackView.addArrangedSubview(commentButton)
        commentStackView.addArrangedSubview(commentCountLabel)

        
        footerContentView.addSubview(createdAtLabel)
        footerContentView.addSubview(updatedAtLabel)
        footerContentView.addSubview(tagsLabel)

        
        
    }
    
    func setupConstraints() {
        
        let textContentLabelBottomConstraint: NSLayoutConstraint = textContentLabel.bottomAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: -12)
        textContentLabelBottomConstraint.priority = UILayoutPriority(250)
        
        NSLayoutConstraint.activate([
            authorContentView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            authorContentView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            authorContentView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            
            postContentView.topAnchor.constraint(equalTo: authorContentView.bottomAnchor, constant: 12),
            postContentView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            postContentView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            postContentView.widthAnchor.constraint(equalToConstant: 350),

            socialContentStackView.topAnchor.constraint(equalTo: postContentView.bottomAnchor, constant: 12),
            socialContentStackView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            socialContentStackView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            socialContentStackView.heightAnchor.constraint(equalToConstant: 48),
            
            footerContentView.topAnchor.constraint(equalTo: socialContentStackView.bottomAnchor, constant: 12),
            footerContentView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            footerContentView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
            footerContentView.heightAnchor.constraint(equalToConstant: 50),
            footerContentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            authorImageView.topAnchor.constraint(equalTo: authorContentView.topAnchor),
            authorImageView.leftAnchor.constraint(equalTo: authorContentView.leftAnchor),
            authorImageView.heightAnchor.constraint(equalToConstant: 100),
            authorImageView.widthAnchor.constraint(equalTo: authorImageView.heightAnchor),
            authorImageView.bottomAnchor.constraint(equalTo: authorContentView.bottomAnchor),
            
            authorNameLabel.topAnchor.constraint(equalTo: authorImageView.topAnchor),
            authorNameLabel.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: 12),
            authorNameLabel.rightAnchor.constraint(equalTo: authorContentView.rightAnchor),
            

            
            textContentLabel.topAnchor.constraint(equalTo: postContentView.topAnchor),
            textContentLabel.leftAnchor.constraint(equalTo: postContentView.leftAnchor),
            textContentLabel.rightAnchor.constraint(equalTo: postContentView.rightAnchor),
            textContentLabelBottomConstraint,
            
            textContentLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20),

            
            
            createdAtLabel.rightAnchor.constraint(equalTo: footerContentView.rightAnchor),

            updatedAtLabel.topAnchor.constraint(equalTo: createdAtLabel.bottomAnchor),
            updatedAtLabel.rightAnchor.constraint(equalTo: footerContentView.rightAnchor),
            updatedAtLabel.bottomAnchor.constraint(equalTo: footerContentView.bottomAnchor),
            
            tagsLabel.bottomAnchor.constraint(equalTo: footerContentView.bottomAnchor),
            tagsLabel.leftAnchor.constraint(equalTo: footerContentView.leftAnchor),
        ])
        
    }
    
}
