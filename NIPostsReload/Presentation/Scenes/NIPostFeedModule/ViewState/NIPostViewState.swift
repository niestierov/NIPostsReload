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
        let date: String
        let likesCount: String
        
        var isExpanded = false
    }
    
    var items: [Post] = []
    private(set) var posts: [NIPost] = []
    
    func getPost(by index: Int) -> NIPost {
        posts[index]
    }
    
    mutating func sort(by sortType: PostFeedSortType) {
        switch sortType {
        case .date:
            posts.sort { $0.timeshamp ?? 0 > $1.timeshamp ?? 0 }
        case .popularity:
            posts.sort { $0.likesCount ?? 0 > $1.likesCount ?? 0}
        case .default:
            posts.sort { $0.postId < $1.postId }
        }
        
        makePost()
    }
    
    mutating func setPosts(_ posts: [NIPost]) {
        self.posts = posts
        makePost()
    }
    
    mutating func makePost() {
        let postViewStates = posts.compactMap { post in
            let isExpanded = items.first { $0.postId == post.postId }?.isExpanded ?? false
            let title = post.title ?? ""
            let previewText = post.previewText ?? ""
            let likesCount = (post.likesCount ?? .zero).stringValue
            let date = Date(timeIntervalSince1970: post.timeshamp ?? .zero).asFormattedString()
            
            return NIPostViewState.Post(
                postId: post.postId,
                title: title,
                previewText: previewText,
                date: date,
                likesCount: likesCount,
                isExpanded: isExpanded
            )
        }
        
        self.items = postViewStates
    }
}
