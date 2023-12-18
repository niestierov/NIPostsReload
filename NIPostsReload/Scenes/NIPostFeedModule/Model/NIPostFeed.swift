//
//  NIPostFeed.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import Foundation

struct NIPostFeed: Decodable {
    let posts: [NIPost]?
}

struct NIPost: Decodable {
    let postId: Int
    let timeshamp: TimeInterval?
    let title: String?
    let previewText: String?
    let likesCount: Int?
}
