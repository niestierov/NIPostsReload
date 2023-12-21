//
//  NIPostFeedBuilder.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedBuilder {
    func createNiPostFeedModule(for navigationController: UINavigationController) -> UIViewController
}

final class DefaultNIPostFeedBuilder: NIPostFeedBuilder {

    // MARK: - Internal -
    
    func createNiPostFeedModule(for navigationController: UINavigationController) -> UIViewController {
        let networkService: NetworkService = DefaultServiceLocator.shared.resolve()
        let apiService: NIPostFeedAPIService = DefaultNIPostFeedAPIService(networkService: networkService)
    
        let viewController = NIPostFeedViewController()
        let router = DefaultNIPostFeedRouter(navigationController: navigationController)
        let presenter = DefaultNIPostFeedPresenter(
            view: viewController,
            router: router,
            apiService: apiService
        )
        
        viewController.setPresenter(presenter)
        
        return viewController
    }
}
