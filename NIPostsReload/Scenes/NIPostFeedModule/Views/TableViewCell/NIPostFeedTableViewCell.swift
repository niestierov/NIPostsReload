//
//  NIPostFeedTableViewCell.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

final class NIPostFeedTableViewCell: UITableViewCell {
    private enum Constant {
        static let defaultHorizontalInset: CGFloat = 20
        static let defaultVerticalInset: CGFloat = 20
        static let systemLikesImage = "heart.circle.fill"
        static let defaultNumberOfLines = 1
        static let postDescriptionNumberOfLines = 2
        static let postTitleFontSize: CGFloat = 18
    }
    
    // MARK: - UI Components -

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: Constant.postTitleFontSize)
        label.numberOfLines = Constant.defaultNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = Constant.postDescriptionNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var likesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.spacing = 5
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = Constant.defaultNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postLikesImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.systemLikesImage)
        view.backgroundColor = .clear
        view.tintColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = Constant.defaultNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Life Cycle -
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    // MARK: - Internal -
    
    func configure(with post: NIPost) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.previewText
        postDateLabel.text = "April 13"
        postLikesLabel.text = String(post.likesCount ?? 0)
    }
}

// MARK: - Private -

private extension NIPostFeedTableViewCell {
    func setupView() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(postTitleLabel)
        mainStackView.addArrangedSubview(postDescriptionLabel)
        mainStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(likesStackView)
        horizontalStackView.addArrangedSubview(postDateLabel)
        
        likesStackView.addArrangedSubview(postLikesImageView)
        likesStackView.addArrangedSubview(postLikesLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constant.defaultVerticalInset
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: contentView.bottomAnchor,
                constant: -Constant.defaultVerticalInset
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constant.defaultHorizontalInset
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constant.defaultHorizontalInset
            ),
        ])
    }
}
