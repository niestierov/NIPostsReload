//
//  NIPostFeedBuilder.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedBuilder {
    func createNiPostFeedModule(router: NIPostFeedRouter) -> UIViewController
}

final class DefaultNIPostFeedBuilder: NIPostFeedBuilder {
    func createNiPostFeedModule(router: NIPostFeedRouter) -> UIViewController {
        let presenter = DefaultNIPostFeedPresenter(router: router)
        let viewController = NIPostFeedViewController(presenter: presenter)
        
        presenter.setView(viewController)
        
        return viewController
    }
}
