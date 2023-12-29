//
//  NIPostDetails.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 18.12.2023.
//

import Foundation

struct NIPostDetails: Decodable {
    let post: NIPostDetail
}

struct NIPostDetail: Decodable {
    let postId: Int
    let timeshamp: TimeInterval?
    let title: String?
    let text: String?
    let likesCount: Int?
    let postImage: String?
}
