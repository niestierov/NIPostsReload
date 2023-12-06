//
//  SceneDelegate.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties -
    
    var window: UIWindow?

    // MARK: - Internal -
    
    func scene(
        _ scene: UIScene, willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        startRootScreen(for: windowScene)
    }

    // MARK: - Private -
    
    private func startRootScreen(for windowScene: UIWindowScene) {
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        let navigationController = UINavigationController()
        
        let builder = DefaultNIPostFeedBuilder()
        let router = DefaultNIPostFeedRouter(
            builder: builder,
            navigationController: navigationController
        )
        
        router.showNiPostFeedModule()

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
