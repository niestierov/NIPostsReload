//
//  NetworkService.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 12.12.2023.
//

import Foundation
import Alamofire

protocol NetworkService {
    func request<T: Decodable>(
        endPoint: EndPoint,
        type: T.Type,
        completion: @escaping (Result<T?, Error>) -> Void
    )
}

final class DefaultNetworkService: NetworkService {
    
    //MARK: - Internal -
    
    func request<T: Decodable>(
        endPoint: EndPoint,
        type: T.Type,
        completion: @escaping (Result<T?, Error>) -> Void
    ) {
        guard let url = endPoint.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        AF.request(
            url,
            method: endPoint.method,
            encoding: endPoint.encoding
        ).responseDecodable(of: type, decoder: JSONDecoder.defaultFromSnakeCase) { response in
            guard response.data != nil else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Private -
    
    private enum NetworkError: Error {
        case invalidURL
        case invalidData
    }
}
