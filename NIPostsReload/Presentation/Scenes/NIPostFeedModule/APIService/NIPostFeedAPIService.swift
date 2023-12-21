//
//  NIPostFeedAPIService.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 20.12.2023.
//

import Foundation

protocol NIPostFeedAPIService {
    func fetchPosts(
        with endpoint: EndPoint,
        completion: @escaping (Result<[NIPost]?, Error>) -> Void
    )
}

final class DefaultNIPostFeedAPIService: NIPostFeedAPIService {
    
    // MARK: - Properties -
    
   private let networkService: NetworkService
    
    // MARK: - Init -
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    // MARK: - Internal -
    
    func fetchPosts(
        with endpoint: EndPoint,
        completion: @escaping (Result<[NIPost]?, Error>) -> Void
    ) {
        let endpoint = EndPoint.list
        
        networkService.request(
            endPoint: endpoint,
            type: NIPostFeed.self
        ) { response in
            switch response {
            case .success(let data):
                let posts = data?.posts
                completion(.success(posts))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
