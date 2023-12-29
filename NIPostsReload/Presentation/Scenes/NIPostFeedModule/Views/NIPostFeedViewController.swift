//
//  NIPostFeedViewController.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedView: AnyObject { 
    func update()
    func showError(message: String)
}

final class NIPostFeedViewController: UIViewController {
    
    // MARK: - Properties -
    
    private var presenter: NIPostFeedPresenter!
    
    // MARK: - UI Components -
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: makeCompositionalLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NIPostFeedCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupCollectionView()
        presenter.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Internal -
    
    func setPresenter(_ presenter: NIPostFeedPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Private -

private extension NIPostFeedViewController {
    func setupView() {
        view.backgroundColor = .white
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func updateCell(
        _ cell: NIPostFeedCollectionViewCell,
        at index: Int
    ) {
        let isExpanded = presenter.changePostIsExpandedState(at: index)
        cell.updateContent(with: isExpanded)
        
        UIView.animate(withDuration: 0.2) {
            cell.layoutIfNeeded()
            self.collectionView.performBatchUpdates(nil, completion: nil)
        }
    }
}

// MARK: - NIPostFeedView -

extension NIPostFeedViewController: NIPostFeedView {
    func update() {
        collectionView.reloadData()
    }
    
    func showError(message: String) {
        showAlert(
            title: AlertConstant.defaultAlertErrorTitle,
            message: message
        )
    }
}

// MARK: - UICollectionViewDataSource -

extension NIPostFeedViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        presenter.getPostFeedCount()
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeue(
            cellType: NIPostFeedCollectionViewCell.self,
            at: indexPath
        )
        let post = presenter.getPostItem(at: indexPath.item)

        cell.configure(with: post) { [weak self] in
            self?.updateCell(cell, at: indexPath.item)
        }
        
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout -

extension NIPostFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        presenter.didSelectPost(at: indexPath.row)
    }
}

// MARK: - UICollectionViewCompositionalLayout -

extension NIPostFeedViewController {
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, environment in
            guard let self else {
                return nil
            }
            
            let item = createCollectionViewItem()
            let group = createCollectionViewVerticalGroup(with: [item])
            let section = createCollectionViewSection(with: group)
            return section
        }

        return layout
    }
}
