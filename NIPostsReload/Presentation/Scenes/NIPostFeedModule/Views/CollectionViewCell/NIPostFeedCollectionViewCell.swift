//
//  NIPostFeedCollectionViewCell.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

final class NIPostFeedCollectionViewCell: UICollectionViewCell {
    private struct Constant {
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
        button.layer.cornerRadius = 12
        button.layer.cornerCurve = .continuous
        button.addTarget(self, action: #selector(tappedExpandButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Properties -
    
    private var updateHandler: (() -> Void)?

    // MARK: - Life Cycle -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }

    // MARK: - Internal -
    
    func configure(with post: NIPostViewState.Post) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.previewText
        postLikesLabel.text = post.likesCount.stringValue
        postDateLabel.text = post.date
        
        updateContent(with: post.isExpanded)
    }
    
    func setUpdateHandler(update: @escaping () -> Void) {
        updateHandler = update
    }
}

// MARK: - Private -

private extension NIPostFeedCollectionViewCell {
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
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            postExpandButton.heightAnchor.constraint(equalToConstant: 35)
        ])

        layoutIfNeeded()
    }
    
    func updateContent(with isExpanded: Bool) {
        postDescriptionLabel.numberOfLines = isExpanded ? .zero : Constant.defaultDescriptionNumberOfLines
        
        updateExpandButtonTitle()
        updateExpandButtonVisibility()
    }
    
    func updateExpandButtonTitle() {
        let title = postDescriptionLabel.numberOfLines == .zero ? Constant.collapseTitle : Constant.expandTitle
        
        postExpandButton.setTitle(title, for: .normal)
    }
    
    func updateExpandButtonVisibility() {
        postExpandButton.isHidden = postDescriptionLabel.fitsInLines()
    }
    
    @objc func tappedExpandButton() {
        postDescriptionLabel.numberOfLines = postDescriptionLabel.numberOfLines == .zero ? Constant.defaultDescriptionNumberOfLines : .zero
       
        updateExpandButtonTitle()
        updateHandler?()
    }
}
