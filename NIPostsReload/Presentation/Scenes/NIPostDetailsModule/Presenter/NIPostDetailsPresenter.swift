//
//  NIPostDetailsPresenter.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import Foundation
import UIKit

protocol NIPostDetailsPresenter {
    func initialSetup()
}

final class DefaultNIPostDetailsPresenter: NIPostDetailsPresenter {
    
    // MARK: - Properties -
    
    private unowned let view: NIPostDetailsView
    private let apiService: NIPostDetailsAPIService
    private var postViewState = NIPostDetailsViewState()
    private let postId: Int
    
    // MARK: - Init -
    
    init(
        view: NIPostDetailsView,
        apiService: NIPostDetailsAPIService,
        postId: Int
    ) {
        self.view = view
        self.apiService = apiService
        self.postId = postId
    }
    
    // MARK: - Internal -
    
    func initialSetup() {
        fetchPost()
    }
}

// MARK: - Private -

private extension DefaultNIPostDetailsPresenter {
    func fetchPost() {        
        apiService.fetchPost(with: postId) { [weak self] response in
            guard let self else {
                return
            }
            
            switch response {
            case .success(let post):
                guard let post else {
                    return
                }
                composePostViewStates(for: post)
            case .failure(let error):
                view.showError(message: error.localizedDescription)
            }
        }
    }
    
    func composePostViewStates(for post: NIPostDetail) {
        postViewState = NIPostDetailsViewState.makeViewState(for: post)
        
        if let post = postViewState.post {
            view.update(with: post)
        }
    }
}
