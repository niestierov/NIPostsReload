//
//  StringIdentifiable+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import Foundation

protocol StringIdentifiable: AnyObject { }

extension StringIdentifiable {
    static var identifier: String {
        return String(describing: self)
    }
}
