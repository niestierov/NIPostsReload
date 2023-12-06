//
//  NIPostFeedPresenter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import Foundation

protocol NIPostFeedPresenter {
    
}

final class DefaultNIPostFeedPresenter: NIPostFeedPresenter {
    
    // MARK: - Properties -
    
    private weak var view: NIPostFeedView?
    
    // MARK: - Internal -
    
    func setView(_ view: NIPostFeedView) {
        self.view = view
    }
}
