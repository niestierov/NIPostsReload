//
//  JSONDecoder+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 13.12.2023.
//

import Foundation

extension JSONDecoder {
    static var defaultFromSnakeCase: JSONDecoder = {
        let encoder = JSONDecoder()
        encoder.keyDecodingStrategy = .convertFromSnakeCase
        return encoder
    }()
}
