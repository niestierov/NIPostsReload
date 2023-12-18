//
//  AppCoordinator.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Properties -
    
    private var window: UIWindow?

    // MARK: - Life Cycle -
    
    init() {}

    // MARK: - Internal -
    
    func start(in windowScene: UIWindowScene) {
        setupServices()
        
        let navigationController = UINavigationController()
        let router = DefaultNIPostFeedRouter(navigationController: navigationController)

        configureWindow(with: navigationController, in: windowScene)
        
        router.showNiPostFeedModule()
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
        let networkService = DefaultNetworkService()
        DefaultServiceLocator.shared.register(service: networkService)
    }
    
    private func setupServices() {
        registerNetworkService()
    }
}
