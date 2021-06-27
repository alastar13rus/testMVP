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
    
    var indexPath: IndexPath!
    
    let postHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postContentView: UIView = {
        let view = UIView()
        view.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postFooterView: UIView = {
        let view = UIView()
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
    
    let authorImageView: CustomImageView = {
        let iv = CustomImageView()
        iv.layer.cornerRadius = 10
        iv.layer.borderWidth = 5
        iv.layer.borderColor = UIColor.systemGray6.cgColor
//        iv.backgroundColor = .systemGray6
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let textContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
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
    }
    
    
//    MARK: - Methods
    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
//        accessoryType = .disclosureIndicator
        setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func setupHierarhy() {
        contentView.addSubview(postHeaderView)
        contentView.addSubview(postContentView)
        contentView.addSubview(postFooterView)
        
        postHeaderView.addSubview(authorNameLabel)
        postHeaderView.addSubview(authorImageView)

        postContentView.addSubview(textContentLabel)

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

            postFooterView.leftAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leftAnchor, constant: 12),
            postFooterView.rightAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.rightAnchor, constant: -12),
            postFooterView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor, constant: -12),
            
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

        ])
    }
    
    func configure(with data: PostData) {
        
        setupConstraints(data)
        
        authorNameLabel.text = data.authorName
        authorImageView.layer.cornerRadius = CGFloat(data.cellHeaderHeight) / 2
        textContentLabel.text = data.textContent
        createdAtLabel.text = data.createdAtString
        updatedAtLabel.text = data.updatedAtString
        tagsLabel.text = data.tagsContent
        isMyFavoriteLabel.text = data.isMyFavorite ? "yes" : "no"
        postTypeLabel.text = data.typeString
        postContents.text = data.contentsString
        
        authorImageView.setImage(data.imageContentURL) { [weak self] succeeded in
            guard let self = self, !succeeded else { return }
            self.authorImageView.image = data.authorGender.getImage()
        }
    }
}
