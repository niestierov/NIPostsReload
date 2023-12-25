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
    private let appStarter = AppStarter()

    // MARK: - Internal -
    
    func scene(
        _ scene: UIScene, 
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        appStarter.start(in: windowScene)
    }
}
