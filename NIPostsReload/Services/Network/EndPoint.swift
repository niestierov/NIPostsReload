//
//  EndPoint.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 12.12.2023.
//

import Foundation
import Alamofire

private struct EndPointConstant {
    static let baseUrl = "https://raw.githubusercontent.com/anton-natife/jsons/master/api"
    static let listPath =  "/main"
    static let detailsPath =  "/posts"
    static let jsonFormat = ".json"
}

enum EndPoint {
    case list
    case details(postId: Int)
    
    var urlString: String {
        switch self {
        case .list, .details:
            return EndPointConstant.baseUrl + path + EndPointConstant.jsonFormat
        }
    }
    
    var url: URL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    var method: HTTPMethod {
        switch self {
        case .list,
             .details:
            return .get
        }
    }
    
    var encoding: ParameterEncoding {
        switch self {
        case .list,
             .details:
            return URLEncoding.default
        }
    }
    
    // MARK: - Private -
    
    private var path: String {
        switch self {
        case .list:
            return EndPointConstant.listPath
        case .details(let postId):
            return EndPointConstant.detailsPath + "/" + postId.stringValue
        }
    }
}
