//
//  AppConfiguration.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 26.12.2023.
//

import Foundation

protocol AppConfiguration {
    func configure()
}

final class DefaultAppConfiguration: AppConfiguration {
    func configure() {
        registerServices()
    }
    
    private func registerServices() {
        registerNetworkService()
    }

    private func registerNetworkService() {
        let networkService: NetworkService = DefaultNetworkService()
        ServiceLocator.shared.register(service: networkService)
    }
}
