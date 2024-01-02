//
//  PostFeedType.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 29.12.2023.
//

import Foundation

enum PostFeedType: CaseIterable {
    case list
    case grid
    case gallery
    
    var title: String {
        switch self {
        case .list:
            return "List"
        case .grid:
            return "Grid"
        case .gallery:
            return "Gallery"
        }
    }
}

