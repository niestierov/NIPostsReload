//
//  NIPostFeedViewController.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedView: AnyObject { 
    func update() -> Void
    func showErrorAlert(message: String) -> Void
}

final class NIPostFeedViewController: UIViewController {
    private struct Constant {
        static let sortFeedNavigationButtonImage = "arrow.up.and.down.text.horizontal"
        static let defaultAlertErrorTitle = "Error"
    }
    
    // MARK: - Properties -
    
    private let presenter: NIPostFeedPresenter!
    private var expandedCellsState = Set<Int>()
    
    // MARK: - UI Components -
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.bounces = false
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.register(NIPostFeedTableViewCell.self)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
        presenter.initialSetup()
    }
    
    init(presenter: NIPostFeedPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private -

private extension NIPostFeedViewController {
    func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = true
        view.backgroundColor = .white
    }
    
    func setupTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func isExpandedCellState(for cellIndex: Int) -> Bool {
        expandedCellsState.contains(cellIndex)
    }
    
    func updateCell(
        _ cell: NIPostFeedTableViewCell,
        at cellIndex: Int
    ) {
        UIView.animate(withDuration: 0.2) { [weak self] in
            cell.layoutIfNeeded()
            self?.tableView.performBatchUpdates(nil, completion: nil)
        }
        
        if isExpandedCellState(for: cellIndex) {
            expandedCellsState.remove(cellIndex)
        } else {
            expandedCellsState.insert(cellIndex)
        }
    }
}

// MARK: - NIPostFeedView -

extension NIPostFeedViewController: NIPostFeedView {
    func update() {
        tableView.reloadData()
    }
    
    func showErrorAlert(message: String) {
        showAlert(
            title: Constant.defaultAlertErrorTitle,
            message: message
        )
    }
}

// MARK: - UITableViewDataSource -

extension NIPostFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getPostFeedCount()
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: NIPostFeedTableViewCell.self, at: indexPath)
        
        let post = presenter.getPostItem(at: indexPath.row)

        cell.configure(
            with: post,
            isExpanded: isExpandedCellState(for: indexPath.row)
        ) { [unowned self] in
            self.updateCell(cell, at: indexPath.row)
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate -

extension NIPostFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
