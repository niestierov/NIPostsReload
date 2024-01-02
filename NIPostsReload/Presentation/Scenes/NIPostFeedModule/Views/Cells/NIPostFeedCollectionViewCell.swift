//
//  NIPostFeedCollectionViewCell.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

final class NIPostFeedCollectionViewCell: UICollectionViewCell {
    private struct Constant {
        static let defaultHorizontalInset: CGFloat = 12
        static let defaultVerticalInset: CGFloat = 12
        static let defaultDescriptionNumberOfLines = 2
        static let systemLikeImageName = "heart.circle.fill"
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
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.contentMode = .top
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.applyPriority(
            contentHuggingPriority: .defaultLow,
            contentCompressionResistancePriority: .defaultLow
        )
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.applyPriority()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var likesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.applyPriority()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.applyPriority()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postLikesImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.systemLikeImageName)
        view.backgroundColor = .clear
        view.tintColor = .red
        view.applyPriority()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.applyPriority()
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
    private lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Properties -
    
    private var updateHandler: EmptyBlock?
    
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
    
    func configure(
        with post: NIPostViewState.Post,
        type: PostFeedType,
        update: @escaping EmptyBlock
    ) {
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.previewText
        postLikesLabel.text = post.likesCount.stringValue
        postDateLabel.text = post.date
        updateHandler = update
        
        updateContent(with: post.isExpanded, for: type)
    }
    
    func updateContent(
        with isExpanded: Bool,
        for type: PostFeedType
    ) {
        switch type {
        case .list:
            updateCellForListType(with: isExpanded)
        case .grid:
            updateCellForGridType()
        case .gallery:
            updateCellForGalleryType()
        }
    }
}

// MARK: - Private -

private extension NIPostFeedCollectionViewCell {
    func setupView() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(mainStackView)
        contentView.addSubview(underlineView)
        
        mainStackView.addArrangedSubview(postTitleLabel)
        mainStackView.addArrangedSubview(postDescriptionLabel)
        mainStackView.addArrangedSubview(detailsStackView)
        mainStackView.addArrangedSubview(postExpandButton)
        
        detailsStackView.addArrangedSubview(likesStackView)
        detailsStackView.addArrangedSubview(postDateLabel)
        
        likesStackView.addArrangedSubview(postLikesImageView)
        likesStackView.addArrangedSubview(postLikesLabel)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(
                equalTo: contentView.topAnchor,
                constant: Constant.defaultVerticalInset
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: contentView.leadingAnchor,
                constant: Constant.defaultHorizontalInset
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: contentView.trailingAnchor,
                constant: -Constant.defaultHorizontalInset
            ),
            
            detailsStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            detailsStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            
            postExpandButton.heightAnchor.constraint(equalToConstant: 35),
            
            underlineView.topAnchor.constraint(
                equalTo: mainStackView.bottomAnchor,
                constant: Constant.defaultVerticalInset
            ),
            underlineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            underlineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 1)
        ])

        layoutIfNeeded()
    }
    
    func updateCellForListType(with isExpanded: Bool) {
        let descriptionLabelNumberOfLines = isExpanded ? .zero : Constant.defaultDescriptionNumberOfLines
        configureMainStackViewContent(descriptionLabelNumberOfLines: descriptionLabelNumberOfLines)
        
        configureContentView()
        updateExpandButton(with: isExpanded)
        configureStackViews()
        updateDetailsStackViewHeight()
    }
    
    func updateCellForGridType() {
        configureMainStackViewContent(
            isUnderlineViewHidden: true,
            titleLabelNumberOfLines: .zero
        )
        configureContentView(
            borderColor: UIColor.black.cgColor,
            borderWidth: 1,
            cornerRadius: 15
        )
        configureStackViews(
            mainStackViewDistribution: .fillProportionally,
            detailsStackViewAlignment: .center,
            detailsStackViewAxis: .vertical
        )
        updateDetailsStackViewHeight()
    }
    
    func updateCellForGalleryType() {
        configureMainStackViewContent()
        configureContentView()
        configureStackViews()
        updateDetailsStackViewHeight()
    }
    
    func configureStackViews(
        mainStackViewDistribution: UIStackView.Distribution = .fill,
        detailsStackViewAlignment: UIStackView.Alignment = .fill,
        detailsStackViewAxis: NSLayoutConstraint.Axis = .horizontal
    ) {
        mainStackView.distribution = mainStackViewDistribution
        detailsStackView.alignment = detailsStackViewAlignment
        detailsStackView.axis = detailsStackViewAxis
    }

    func updateDetailsStackViewHeight() {
        detailsStackView.removeConstraints(
            detailsStackView.constraints.filter { $0.firstAttribute == .height }
        )

        let targetSize = UIView.layoutFittingCompressedSize
        let detailsStackViewHeight = detailsStackView.systemLayoutSizeFitting(targetSize).height
        detailsStackView.heightAnchor.constraint(equalToConstant: detailsStackViewHeight).isActive = true
    }
    
    func configureMainStackViewContent(
        isUnderlineViewHidden: Bool = false,
        isExpandButtonHidden: Bool = true,
        titleLabelNumberOfLines: Int = 1,
        descriptionLabelNumberOfLines: Int = .zero
    ) {
        underlineView.isHidden = isUnderlineViewHidden
        postExpandButton.isHidden = isExpandButtonHidden
        postTitleLabel.numberOfLines = titleLabelNumberOfLines
        postDescriptionLabel.numberOfLines = descriptionLabelNumberOfLines
    }
    
    func configureContentView(
        borderColor: CGColor? = .none,
        borderWidth: CGFloat = .zero,
        cornerRadius: CGFloat = .zero
    ) {
        contentView.layer.borderColor = borderColor
        contentView.layer.borderWidth = borderWidth
        contentView.layer.cornerRadius = cornerRadius
    }
    
    func updateExpandButton(with isExpanded: Bool) {
        postExpandButton.isHidden = postDescriptionLabel.fitsInLines()
        
        if !postExpandButton.isHidden {
            let title = isExpanded ? Constant.collapseTitle : Constant.expandTitle
            postExpandButton.setTitle(title, for: .normal)
        }
    }
    
    @objc func tappedExpandButton() {
        updateHandler?()
    }
}
