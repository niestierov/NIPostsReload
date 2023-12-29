//
//  NIPostFeedRouter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedRouter {
    func showNiPostDetailsModule(postId: Int)
}

final class DefaultNIPostFeedRouter: BaseRouter, NIPostFeedRouter {
    
    // MARK: - Properties -
    
    var root: UIViewController
    
    // MARK: - Init -
    
    init(root: UIViewController) {
        self.root = root
    }
    
    // MARK: - Internal -
    
    func showNiPostDetailsModule(postId: Int) {
        let niPostDetailsModule = DefaultNIPostDetailsBuilder().createNiPostDetailsModule(postId: postId)
        root.navigationController?.pushViewController(niPostDetailsModule, animated: true)
    }
}
