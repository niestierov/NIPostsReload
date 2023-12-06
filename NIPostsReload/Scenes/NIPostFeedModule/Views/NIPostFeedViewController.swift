//
//  NIPostFeedViewController.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedView: AnyObject { }

final class NIPostFeedViewController: UIViewController {

    // MARK: - Properties -
    
    private let presenter: NIPostFeedPresenter!
    
    // MARK: - Life Cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    init(presenter: NIPostFeedPresenter) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - NIPostFeedView -

extension NIPostFeedViewController: NIPostFeedView {}
