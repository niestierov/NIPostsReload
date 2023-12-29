//
//  NIPostFeedTableViewCell.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

final class NIPostFeedTableViewCell: UITableViewCell {
    private struct Constant {
        static let defaultHorizontalInset: CGFloat = 20
        static let defaultVerticalInset: CGFloat = 20
        static let defaultDescriptionNumberOfLines = 2
        static let systemLikesImage = "heart.circle.fill"
        static let expandTitle = "Expand"
        static let collapseTitle = "Collapse"
    }
    
    // MARK: - UI Components -

    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .top
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var likesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postExpandButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constant.expandTitle, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .darkGray
        button.applyRoundedCorners(cornerRadius: 12)
        button.addTarget(self, action: #selector(tappedExpandButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties -
    
    private var updateHandler: EmptyBlock?
    
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
    
    func configure(
        with post: NIPostViewState.Post,
        update: @escaping EmptyBlock
    ) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.previewText
        postLikesLabel.text = post.likesCount.stringValue
        postDateLabel.text = post.date
        updateHandler = update
        
        updateContent(with: post.isExpanded)
        updateExpandButtonVisibility()
    }
    
    func updateContent(with isExpanded: Bool) {
        let title = isExpanded ? Constant.collapseTitle : Constant.expandTitle
        postExpandButton.setTitle(title, for: .normal)
        
        postDescriptionLabel.numberOfLines = isExpanded ? .zero : Constant.defaultDescriptionNumberOfLines
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
        mainStackView.addArrangedSubview(postExpandButton)
        
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
            
            postExpandButton.heightAnchor.constraint(equalToConstant: 35)
        ])

        layoutIfNeeded()
    }
    
    func updateExpandButtonVisibility() {
        postExpandButton.isHidden = postDescriptionLabel.fitsInLines()
    }
    
    @objc func tappedExpandButton() {
        updateHandler?()
    }
}
