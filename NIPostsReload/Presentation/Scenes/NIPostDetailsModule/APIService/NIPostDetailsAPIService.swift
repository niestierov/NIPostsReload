//
//  NIPostDetailsAPIService.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 21.12.2023.
//

import Foundation

protocol NIPostDetailsAPIService {
    func fetchPost(
        with postId: Int,
        completion: @escaping (Result<NIPostDetail?, Error>) -> Void
    )
}

final class DefaultNIPostDetailsAPIService: NIPostDetailsAPIService {
    
    // MARK: - Properties -
    
   private let networkService: NetworkService
    
    // MARK: - Init -
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Internal -
    
    func fetchPost(
        with postId: Int,
        completion: @escaping (Result<NIPostDetail?, Error>) -> Void
    ) {
        networkService.request(
            endPoint: EndPoint.details(postId: postId),
            type: NIPostDetails.self
        ) { response in
            switch response {
            case .success(let data):
                let posts = data?.post
                completion(.success(posts))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
