//
//  BaseRouter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 26.12.2023.
//

import UIKit

class BaseRouter {
    
    // MARK: - Properties -
    
    var root: UIViewController!
    
    // MARK: - Internal -
    
    func inject(root: UIViewController) {
        self.root = root
    }
}
