//
//  NIPostDetailsViewController.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import UIKit

protocol NIPostDetailsView: AnyObject {
    func update(with: NIPostDetailsViewState.Post)
    func showError(message: String?)
}

final class NIPostDetailsViewController: UIViewController {
    private struct Constant {
        static let systemLikesImage = "heart.circle.fill"
        static let defaultHorizontalInset: CGFloat = 20
        static let defaultVerticalInset: CGFloat = 20
        static let defaultFontSize: CGFloat = 18
    }
    
    // MARK: - UI Components -
    
    private lazy var postDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: Constant.defaultFontSize, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: Constant.defaultFontSize, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postLikesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = .zero
        label.font = .systemFont(ofSize: Constant.defaultFontSize, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private lazy var postImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var postLikesImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: Constant.systemLikesImage)
        view.backgroundColor = .clear
        view.tintColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.isScrollEnabled = true
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Properties -
    
    private var presenter: NIPostDetailsPresenter!
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
        presenter.initialSetup()
    }
    
    // MARK: - Internal -
    
    func setPresenter(_ presenter: NIPostDetailsPresenter) {
        self.presenter = presenter
    }
}

// MARK: - NIPostDetailsView -

extension NIPostDetailsViewController: NIPostDetailsView {
    func update(with post: NIPostDetailsViewState.Post) {
        postImageView.setImage(with: post.postImage)
        
        postTitleLabel.text = post.title
        postDescriptionLabel.text = post.text
        postDateLabel.text = post.date
        postLikesLabel.text = post.likesCount.stringValue
    }
    
    func showError(message: String?) {
        showAlert(
            title: AlertConstant.defaultAlertErrorTitle,
            message: message ?? AlertConstant.defaultAlertErrorMessage
        )
    }
}

// MARK: - Private -

private extension NIPostDetailsViewController {
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(postImageView)
        scrollView.addSubview(mainStackView)

        mainStackView.addArrangedSubview(postTitleLabel)
        mainStackView.addArrangedSubview(postDescriptionLabel)
        mainStackView.addArrangedSubview(horizontalStackView)
        
        horizontalStackView.addArrangedSubview(likesStackView)
        horizontalStackView.addArrangedSubview(postDateLabel)
        
        likesStackView.addArrangedSubview(postLikesImageView)
        likesStackView.addArrangedSubview(postLikesLabel)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            postImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            postImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            postImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            postImageView.widthAnchor.constraint(equalTo: view.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            
            mainStackView.topAnchor.constraint(
                equalTo: postImageView.bottomAnchor,
                constant: Constant.defaultVerticalInset
            ),
            mainStackView.bottomAnchor.constraint(
                equalTo: scrollView.bottomAnchor
            ),
            mainStackView.leadingAnchor.constraint(
                equalTo: scrollView.leadingAnchor,
                constant: Constant.defaultHorizontalInset
            ),
            mainStackView.trailingAnchor.constraint(
                equalTo: scrollView.trailingAnchor,
                constant: -Constant.defaultHorizontalInset
            ),
        ])
    }
}
