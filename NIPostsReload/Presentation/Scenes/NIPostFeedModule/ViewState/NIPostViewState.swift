//
//  NIPostViewState.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 19.12.2023.
//

import Foundation

struct NIPostViewState {
    struct Post {
        let postId: Int
        let title: String
        let previewText: String
        let date: Date
        let likesCount: Int
        
        var isExpanded = false
    }
    
    var posts: [Post]
}

extension NIPostViewState {
    static func makeViewState(for posts: [NIPost]) -> NIPostViewState {
        let postViewStates = posts.compactMap { post in
            let postId = post.postId
            let title = post.title ?? ""
            let previewText = post.previewText ?? ""
            let likesCount = post.likesCount ?? .zero
            let date = Date(timeIntervalSince1970: post.timeshamp ?? .zero)
            
            return NIPostViewState.Post(
                postId: postId,
                title: title,
                previewText: previewText,
                date: date,
                likesCount: likesCount
            )
        }
        
        return NIPostViewState(posts: postViewStates)
    }
}
