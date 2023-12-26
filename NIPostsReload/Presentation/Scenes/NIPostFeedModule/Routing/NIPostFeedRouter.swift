//
//  NIPostFeedRouter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedRouter: BaseRouter {
    func showNiPostDetailsModule()
}

final class DefaultNIPostFeedRouter: BaseRouter, NIPostFeedRouter {
    func showNiPostDetailsModule() { }
}
