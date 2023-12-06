//
//  NIPostFeedViewController.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedView: AnyObject { }

final class NIPostFeedViewController: UIViewController {
    private enum Constant {
        static let navigationBarTitle = "NIPostFeed"
        static let sortFeedNavigationButtonImage = "arrow.up.and.down.text.horizontal"
    }
    
    // MARK: - Properties -
    
    private let presenter: NIPostFeedPresenter!
    
    // MARK: - UI Components -
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: view.safeAreaLayoutGuide.layoutFrame)
        table.bounces = false
        table.backgroundColor = .white
        table.delegate = self
        table.dataSource = self
        table.rowHeight = UITableView.automaticDimension
        table.register(
            NIPostFeedTableViewCell.self,
            forCellReuseIdentifier: NIPostFeedTableViewCell.identifier
        )
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
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
    }
    
    func setupTableView() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        tableView.tableFooterView = UIView()
    }
    
    @objc func sortButtonTapped() {

    }
}

// MARK: - NIPostFeedView -

extension NIPostFeedViewController: NIPostFeedView {}

extension NIPostFeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeue(cellType: NIPostFeedTableViewCell.self, at: indexPath)
        
        let post = NIPost(postId: 1, timeshamp: 1, title: "Test Test Test Test Test Test Test Test TestTest Test Test", previewText: "Test Test Test2 Test Test TestTest Test TestTest Test TestTest Test TestTest Test Test Test Test Test", likesCount: 123)
        
        cell.configure(with: post)
        
        return cell
    }
}

extension NIPostFeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
    }
}
