//
//  NIPostFeedRouter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedRouter {
    func showNiPostDetailsModule()
}

final class DefaultNIPostFeedRouter: NIPostFeedRouter {
    
    // MARK: - Properties -
    
    private let navigationController: UINavigationController
    
    // MARK: - Init -
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Internal -
    
    func showNiPostDetailsModule() { }
}
