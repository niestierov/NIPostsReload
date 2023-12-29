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

final class DefaultNIPostFeedRouter: BaseRouter, NIPostFeedRouter {
    
    // MARK: - Properties -
    
    var root: UIViewController
    
    // MARK: - Init -
    
    init(root: UIViewController) {
        self.root = root
    }
    
    // MARK: - Internal -
    
    func showNiPostDetailsModule() { }
}
