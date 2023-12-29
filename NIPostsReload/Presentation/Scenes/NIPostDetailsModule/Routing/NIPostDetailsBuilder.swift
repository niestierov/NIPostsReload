//
//  NIPostDetailsBuilder.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import UIKit

protocol NIPostDetailsBuilder {
    func createNiPostDetailsModule(postId: Int) -> UIViewController
}

final class DefaultNIPostDetailsBuilder: NIPostDetailsBuilder {

    // MARK: - Internal -
    
    func createNiPostDetailsModule(postId: Int) -> UIViewController {
        let networkService: NetworkService = ServiceLocator.shared.resolve()
        let apiService: NIPostDetailsAPIService = DefaultNIPostDetailsAPIService(networkService: networkService)

        let viewController = NIPostDetailsViewController()
        let presenter = DefaultNIPostDetailsPresenter(
            view: viewController,
            apiService: apiService,
            postId: postId
        )
        
        viewController.setPresenter(presenter)
        
        return viewController
    }
}
