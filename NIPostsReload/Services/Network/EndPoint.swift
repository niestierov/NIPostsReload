//
//  EndPoint.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 12.12.2023.
//

import Foundation
import Alamofire

private struct EndPointConstant {
    static let baseUrl = "https://raw.githubusercontent.com"
    static let jsonFormat = ".json"
    
    enum UrlPath {
        case list
        case details(id: Int)
        
        var component: String {
            switch self {
            case .list:
                return "/anton-natife/jsons/master/api/main.json"
            case .details:
                return "/anton-natife/jsons/master/api/posts/"
            }
        }
    }
}

enum EndPoint {
    case list
    case details(id: Int)
    
    var urlString: String {
        switch self {
        case .list, .details:
            return EndPointConstant.baseUrl + path
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
            return EndPointConstant.UrlPath.list.component
        case .details(let id):
            return EndPointConstant.UrlPath.details(id: id).component + String(id) + EndPointConstant.jsonFormat
        }
    }
}
