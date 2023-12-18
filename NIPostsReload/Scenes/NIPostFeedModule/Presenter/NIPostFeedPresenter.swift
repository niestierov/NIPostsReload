//
//  NIPostFeedPresenter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import Foundation

protocol NIPostFeedPresenter {
    func initialSetup()
    func getPostFeedCount() -> Int
    func getPostItem(at index: Int) -> NIPost
}

final class DefaultNIPostFeedPresenter: NIPostFeedPresenter {
    
    // MARK: - Properties -
    
    private let router: NIPostFeedRouter
    private weak var view: NIPostFeedView?
    private let networkService: NetworkService
    private var postFeed: [NIPost] = []
    
    // MARK: - Life Cycle -
    
    init(
        router: NIPostFeedRouter,
        networkService: NetworkService
    ) {
        self.router = router
        self.networkService = networkService
    }
    
    // MARK: - Internal -
    
    func setView(_ view: NIPostFeedView) {
        self.view = view
    }
    
    func initialSetup() {
        fetchPosts()
    }
    
    func getPostFeedCount() -> Int {
        postFeed.count
    }
    
    func getPostItem(at index: Int) -> NIPost {
        postFeed[index]
    }
}

// MARK: - Private -

private extension DefaultNIPostFeedPresenter {
    func fetchPosts() {
        let endpoint = EndPoint.list
        
        networkService.request(
            endPoint: endpoint,
            type: NIPostFeed.self
        ) { [weak self] response in
            guard let self else {
                return
            }
            
            switch response {
            case .success(let data):
                self.postFeed = data?.posts ?? []
                self.view?.update()
                
            case .failure(let error):
                self.view?.showErrorAlert(message: error.localizedDescription)
            }
        }
    }
}
