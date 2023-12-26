//
//  NIPostFeedBuilder.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedBuilder {
    func createNiPostFeedModule() -> UINavigationController
}

final class DefaultNIPostFeedBuilder: NIPostFeedBuilder {

    // MARK: - Internal -
    
    func createNiPostFeedModule() -> UINavigationController {
        let networkService: NetworkService = ServiceLocator.shared.resolve()
        let apiService: NIPostFeedAPIService = DefaultNIPostFeedAPIService(networkService: networkService)
    
        let viewController = NIPostFeedViewController()
        let router = DefaultNIPostFeedRouter()
        let presenter = DefaultNIPostFeedPresenter(
            view: viewController,
            router: router,
            apiService: apiService
        )
        
        viewController.setPresenter(presenter)
        router.inject(root: viewController)
        
        return UINavigationController(rootViewController: viewController)
    }
}
