//
//  AppStarter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import UIKit

final class AppStarter {
    
    // MARK: - Properties -
    
    private var window: UIWindow?

    // MARK: - Init -
    
    init() {
        registerServices()
    }

    // MARK: - Internal -
    
    func start(in windowScene: UIWindowScene) {
        let navigationController = UINavigationController()
        let niPostFeedModule = DefaultNIPostFeedBuilder().createNiPostFeedModule(for: navigationController)

        configureWindow(with: navigationController, in: windowScene)
        
        navigationController.setViewControllers([niPostFeedModule], animated: true)
    }

    // MARK: - Private -

    private func configureWindow(
        with navigationController: UINavigationController,
        in windowScene: UIWindowScene
    ) {
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        self.window = window
    }
    
    private func registerNetworkService() {
        let networkService: NetworkService = DefaultNetworkService()
        DefaultServiceLocator.shared.register(service: networkService)
    }
    
    private func registerServices() {
        registerNetworkService()
    }
}
