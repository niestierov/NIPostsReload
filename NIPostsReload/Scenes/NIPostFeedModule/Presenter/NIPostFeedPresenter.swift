//
//  NIPostFeedPresenter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import Foundation

protocol NIPostFeedPresenter {
    var getPostFeedCount: Int { get }
    func getPostItem(at index: Int) -> NIPost
}

final class DefaultNIPostFeedPresenter: NIPostFeedPresenter {
    
    // MARK: - Properties -
    
    private let router: NIPostFeedRouter
    private weak var view: NIPostFeedView?
    private var postFeed: [NIPost] = []
    
    // MARK: - Life Cycle -
    
    init(router: NIPostFeedRouter) {
        self.router = router
    }
    
    // MARK: - Internal -
    
    func setView(_ view: NIPostFeedView) {
        self.view = view
    }
    
    var getPostFeedCount: Int {
        postFeed.count
    }
    
    func getPostItem(at index: Int) -> NIPost {
        postFeed[index]
    }
}
