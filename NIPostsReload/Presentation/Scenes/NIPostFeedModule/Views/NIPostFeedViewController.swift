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
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NIPostFeedTableViewCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func updateCell(
        _ cell: NIPostFeedTableViewCell,
        at index: Int
    ) {
        let isExpanded = presenter.changePostIsExpandedState(at: index)
        cell.updateContent(with: isExpanded)
        
        UIView.animate(withDuration: 0.2) {
            cell.layoutIfNeeded()
            self.tableView.performBatchUpdates(nil, completion: nil)
        }
    }
}

// MARK: - NIPostFeedView -

extension NIPostFeedViewController: NIPostFeedView {
    func update() {
        tableView.reloadData()
    }
    
    func showError(message: String) {
        showAlert(
            title: AlertConstant.defaultAlertErrorTitle,
            message: message
        )
    }
}

// MARK: - UICollectionViewDataSource -

extension NIPostFeedViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        presenter.getPostFeedCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(
            cellType: NIPostFeedTableViewCell.self,
            at: indexPath
        )
        let post = presenter.getPostItem(at: indexPath.item)

        cell.setUpdateHandler { [weak self] in
            self?.updateCell(cell, at: indexPath.item)
        }
        cell.configure(with: post)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout -

extension NIPostFeedViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        presenter.didSelectPost(at: indexPath.row)
    }
}
