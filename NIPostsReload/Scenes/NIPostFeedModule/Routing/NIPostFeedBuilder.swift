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

    // MARK: - Internal -
    
    func createNiPostFeedModule(router: NIPostFeedRouter) -> UIViewController {
        let presenter = DefaultNIPostFeedPresenter(
            router: router,
            networkService: makeNetworkService()
        )
        let viewController = NIPostFeedViewController(presenter: presenter)
        
        presenter.setView(viewController)
        
        return viewController
    }
    
    // MARK: - Private -
    
    private func makeNetworkService() -> NetworkService {
        return DefaultServiceLocator.shared.resolve() ?? DefaultNetworkService()
    }
}
