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
        
        init(
            title: String = "",
            text: String = "",
            date: String = "",
            likesCount: Int = .zero,
            postImage: String = ""
        ) {
            self.title = title
            self.text = text
            self.date = date
            self.likesCount = likesCount
            self.postImage = postImage
        }
    }
    
    // MARK: - Init -
    
    init(post: Post = Post()) {
        self.post = post
    }
    
    // MARK: - Properties -
    
    var post: Post
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
