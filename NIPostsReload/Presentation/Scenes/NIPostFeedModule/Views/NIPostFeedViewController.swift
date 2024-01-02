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
    private struct Constant {
        static var tabList: [String] = PostFeedType.allCases.map { $0.title }
        static let defaultInset: CGFloat = 10
        static let defaultItemInset: CGFloat = 5
        static let gridItemHeight: CGFloat = 300
    }
    
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
    private lazy var tabView: CustomTabView = {
        let view = CustomTabView(tabs: Constant.tabList)
        view.didSelectTabAt = { [weak self] index in
            self?.updateCollectionViewFeedType(for: index)
        }
        view.configure(
            backgroundColor: .white,
            indicatorColor: .systemBlue,
            defaultTabColor: .darkGray,
            selectedTabColor: .systemBlue
        )
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        presenter.initialSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    // MARK: - Internal -
    
    func setPresenter(_ presenter: NIPostFeedPresenter) {
        self.presenter = presenter
    }
}

// MARK: - Private -

private extension NIPostFeedViewController {
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
    }
    
    func setupView() {
        view.backgroundColor = .white
        
        view.addSubview(tabView)
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            tabView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tabView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tabView.heightAnchor.constraint(equalToConstant: 50),

            collectionView.topAnchor.constraint(equalTo: tabView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func updateCollectionViewFeedType(for index: Int) {
        presenter.didSelectFeedType(with: Constant.tabList[index])
        updateCollectionView()
    }

    func updateCollectionView() {
        updateCollectionViewLayout()
        collectionView.scrollToItem(
            at: [.zero, .zero],
            at: .top,
            animated: false
        )
    }
    
    func updateCollectionViewLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.layoutIfNeeded()
        collectionView.reloadData()
    }
    
    func updateCell(
        _ cell: NIPostFeedCollectionViewCell,
        at index: Int
    ) {
        let isExpanded = presenter.changePostIsExpandedState(at: index)
        let type = presenter.selectedFeedType
        
        cell.updateContent(with: isExpanded, for: type)
        
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
        let type = presenter.selectedFeedType
        
        cell.configure(
            with: post,
            type:type
        ) { [weak self] in
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

// MARK: - CollectionViewLayoutProvider -

extension NIPostFeedViewController: CollectionViewLayoutProvider {
    func makeCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] section, environment in
            guard let self else {
                return nil
            }
            
            switch presenter.selectedFeedType {
            case .list:
                return makeListSection()
            case .grid:
                return makeGridSection()
            case .gallery:
                return makeGallerySection()
            }
        }

        return layout
    }
    
    func makeListSection() -> NSCollectionLayoutSection {
         let item = createItem()
         let group = createVerticalGroup(with: [item])
         let section = createSection(with: group)
         return section
     }

    func makeGridSection() -> NSCollectionLayoutSection {
        let item = createItem(
            width: .fractionalWidth(0.5),
            height: .absolute(Constant.gridItemHeight)
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: Constant.defaultItemInset,
            leading: .zero,
            bottom: Constant.defaultItemInset,
            trailing: .zero
        )
        
        let horizontalGroup = createHorizontalGroup(with: [item, item])
        horizontalGroup.interItemSpacing = .fixed(Constant.defaultInset)
        
        let section = createSection(with: horizontalGroup)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: Constant.defaultInset,
            leading: Constant.defaultInset,
            bottom: Constant.defaultInset,
            trailing: Constant.defaultInset
        )
        
        return section
    }

    func makeGallerySection() -> NSCollectionLayoutSection {
        let item = createItem()
        let group = createVerticalGroup(with: [item])
        let section = createSection(with: group)
        return section
    }
}
