//
//  NIPostViewState.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 19.12.2023.
//

import Foundation

struct NIPostViewState {
    struct Post {
        let title: String
        let previewText: String
        let date: String
        let likesCount: String
        
        var isExpanded = false
    }
    
    var items: [Post] = []
    private var posts: [NIPost] = []
    
    mutating func sort(by sortType: PostFeedSortType) {
        switch sortType {
        case .date:
            posts.sort { $0.timeshamp ?? 0 > $1.timeshamp ?? 0 }
        case .popularity:
            posts.sort { $0.likesCount ?? 0 > $1.likesCount ?? 0}
        case .default:
            posts.sort { $0.postId < $1.postId }
        }
        
        makeViewState()
    }
    
    func getPost(ad index: Int) -> NIPost {
        posts[index]
    }
    
    mutating func setPosts(_ posts: [NIPost]) {
        self.posts = posts
        makeViewState()
    }
    
    mutating func makeViewState() {
        let postViewStates = posts.compactMap { post in
            let title = post.title ?? ""
            let previewText = post.previewText ?? ""
            let likesCount = (post.likesCount ?? .zero).stringValue
            let date = Date(timeIntervalSince1970: post.timeshamp ?? .zero).asFormattedString()
            
            return NIPostViewState.Post(
                title: title,
                previewText: previewText,
                date: date,
                likesCount: likesCount
            )
        }
        
        self.items = postViewStates
    }
}
