//
//  NIPostFeedPresenter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import Foundation

protocol NIPostFeedPresenter: AnyObject {
    func initialSetup()
    func getPostFeedCount() -> Int
    func getPostItem(at index: Int) -> NIPostViewState.Post
    func didSelectItem(at: Int)
    func changePostIsExpandedState(at index: Int)
}

final class DefaultNIPostFeedPresenter: NIPostFeedPresenter {
    
    // MARK: - Properties -
    
    private let router: NIPostFeedRouter
    private weak var view: NIPostFeedView?
    private let apiService: NIPostFeedAPIService
    private var postViewState: NIPostViewState
    
    // MARK: - Life Cycle -
    
    init(
        view: NIPostFeedView,
        router: NIPostFeedRouter,
        apiService: NIPostFeedAPIService
    ) {
        self.view = view
        self.router = router
        self.apiService = apiService
        postViewState = NIPostViewState(posts: [])
    }
    
    // MARK: - Internal -
    
    func initialSetup() {
        updatePosts()
    }
    
    func getPostFeedCount() -> Int {
        postViewState.posts.count
    }
    
    func getPostItem(at index: Int) -> NIPostViewState.Post {
        postViewState.posts[index]
    }
    
    func didSelectItem(at: Int) {
        router.showNiPostDetailsModule()
    }
    
    func changePostIsExpandedState(at index: Int) {
        postViewState.posts[index].isExpanded.toggle()
    }
}

// MARK: - Private -

private extension DefaultNIPostFeedPresenter {
    func updatePosts() {
        apiService.fetchPosts(with: EndPoint.list) { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let posts):
                guard let posts else {
                    view?.showError(message: AlertConstant.defaultAlertErrorMessage)
                    return
                }
                composePostViewStates(for: posts)
            case .failure(let error):
                view?.showError(message: error.localizedDescription)
            }
        }
    }
    
    func composePostViewStates(for posts: [NIPost]) {
        postViewState = NIPostViewState.makeViewState(for: posts)
        self.view?.update()
    }
}
