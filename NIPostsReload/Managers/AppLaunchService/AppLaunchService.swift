//
//  AppStarter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import UIKit

final class AppLaunchService {
    
    // MARK: - Properties -
    
    private var window: UIWindow?
    private let appConfiguration: AppConfiguration
    
    // MARK: - Init -
    
    init(appConfiguration: AppConfiguration) {
        self.appConfiguration = appConfiguration
    }

    // MARK: - Internal -
    
    func start(in windowScene: UIWindowScene) {
        appConfiguration.configure()
        
        let niPostFeedModule = DefaultNIPostFeedBuilder().createNiPostFeedModule()
        configureWindow(with: niPostFeedModule, in: windowScene)
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
}
