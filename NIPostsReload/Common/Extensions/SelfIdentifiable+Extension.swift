//
//  SelfIdentifiable+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import Foundation

protocol SelfIdentifiable: AnyObject { }

extension SelfIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
