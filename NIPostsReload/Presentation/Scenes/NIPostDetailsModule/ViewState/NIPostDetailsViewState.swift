//
//  NIPostDetailsViewState.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 21.12.2023.
//

import Foundation

struct NIPostDetailsViewState {
    struct Post {
        let title: String
        let text: String
        let date: String
        let likesCount: Int
        let postImage: String
    }
    
    var post: Post?
}

extension NIPostDetailsViewState {
    static func makeViewState(for post: NIPostDetail) -> NIPostDetailsViewState {
        let title = post.title ?? ""
        let text = post.text ?? ""
        let likesCount = post.likesCount ?? .zero
        let postImage = post.postImage ?? ""
        
        let date = Date(timeIntervalSince1970: post.timeshamp ?? .zero)
        let dateString = date.asFormattedString()
        
        let post = NIPostDetailsViewState.Post(
            title: title,
            text: text,
            date: dateString,
            likesCount: likesCount,
            postImage: postImage
        )
        
        return NIPostDetailsViewState(post: post)
    }
}
