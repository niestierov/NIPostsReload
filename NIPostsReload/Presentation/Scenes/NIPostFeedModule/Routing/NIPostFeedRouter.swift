//
//  NIPostFeedRouter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedRouter {
    func showPostDetails(postId: Int)
}

final class DefaultNIPostFeedRouter: BaseRouter, NIPostFeedRouter {
    
    // MARK: - Properties -
    
    var root: UIViewController
    
    // MARK: - Init -
    
    init(root: UIViewController) {
        self.root = root
    }
    
    // MARK: - Internal -
    
    func showPostDetails(postId: Int) {
        let postDetails = DefaultNIPostDetailsBuilder().createNiPostDetailsModule(postId: postId)
        root.navigationController?.pushViewController(postDetails, animated: true)
    }
}
