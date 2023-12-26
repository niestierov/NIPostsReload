//
//  SceneDelegate.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Properties -
    
    var window: UIWindow?
    private let appConfiguration: AppConfiguration = DefaultAppConfiguration()
    private var appLaunchService: AppLaunchService?

    // MARK: - Internal -
    
    func scene(
        _ scene: UIScene, 
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        appLaunchService = AppLaunchService(appConfiguration: appConfiguration)
        appLaunchService?.start(in: windowScene)
    }
}
