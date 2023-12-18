//
//  NIPostFeedRouter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedRouter {
    func showNiPostFeedModule()
}

final class DefaultNIPostFeedRouter: NIPostFeedRouter {
    
    // MARK: - Properties -
    
    private let builder = DefaultNIPostFeedBuilder()
    private let navigationController: UINavigationController
    
    // MARK: - Life Cycle -
    
    init(
        navigationController: UINavigationController
    ) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal -
    
    func showNiPostFeedModule() {
        let niPostFeedModule = builder.createNiPostFeedModule(router: self)
        navigationController.setViewControllers([niPostFeedModule], animated: true)
    }
}
