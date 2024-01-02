//
//  NIPostFeedPresenter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 03.12.2023.
//

import UIKit

protocol NIPostFeedPresenter: AnyObject {
    var selectedFeedType: PostFeedType { get }
    
    func initialSetup()
    func getPostFeedCount() -> Int
    func getPostItem(at index: Int) -> NIPostViewState.Post
    func didSelectPost(at index: Int)
    @discardableResult func changePostIsExpandedState(at index: Int) -> Bool
    func didSelectFeedType(with index: Int)
}

final class DefaultNIPostFeedPresenter: NIPostFeedPresenter {
    
    // MARK: - Properties -
    
    private let router: NIPostFeedRouter
    private unowned let view: NIPostFeedView
    private let apiService: NIPostFeedAPIService
    private var postViewState = NIPostViewState(posts: [])
    private(set) var selectedFeedType: PostFeedType = .list
    
    // MARK: - Life Cycle -
    
    init(
        view: NIPostFeedView,
        router: NIPostFeedRouter,
        apiService: NIPostFeedAPIService
    ) {
        self.view = view
        self.router = router
        self.apiService = apiService
    }
    
    // MARK: - Internal -
    
    func initialSetup() {
        updatePosts()
    }
    
    func getPostItem(at index: Int) -> NIPostViewState.Post {
        postViewState.posts[index]
    }
    
    func getPostFeedCount() -> Int {
        postViewState.posts.count
    }
    
    func didSelectPost(at index: Int) {
        let postId = postViewState.posts[index].postId
        router.showPostDetails(postId: postId)
    }
    
    @discardableResult
    func changePostIsExpandedState(at index: Int) -> Bool {
        postViewState.posts[index].isExpanded.toggle()
        return postViewState.posts[index].isExpanded
    }
    
    func didSelectFeedType(with index: Int) {
        guard index >= .zero,
              index < PostFeedType.allCases.count else {
            view.showError(message: AlertConstant.defaultAlertErrorMessage)
            return
        }

        let selectedType = PostFeedType.allCases[index]

        guard selectedType != self.selectedFeedType else {
            return
        }
        self.selectedFeedType = selectedType
        setAllPostsIsExpandedState(to: false)
    }
}

// MARK: - Private -

private extension DefaultNIPostFeedPresenter {
    func updatePosts() {
        apiService.fetchPosts { [weak self] result in
            guard let self else {
                return
            }

            switch result {
            case .success(let posts):
                guard let posts else {
                    return
                }
                composePostViewStates(for: posts)
            case .failure(let error):
                view.showError(message: error.localizedDescription)
            }
        }
    }
    
    func composePostViewStates(for posts: [NIPost]) {
        postViewState = NIPostViewState.makeViewState(for: posts)
        view.update()
    }
    
    func setAllPostsIsExpandedState(to value: Bool) {
        postViewState.posts.indices.forEach {
            postViewState.posts[$0].isExpanded = value
        }
    }
}
