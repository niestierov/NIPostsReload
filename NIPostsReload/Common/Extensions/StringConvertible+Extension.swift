//
//  StringConvertible+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import Foundation

protocol StringConvertible {
    var stringValue: String { get }
}

extension Double: StringConvertible {
    var stringValue: String {
        return String(format: "%.1f", self)
    }
}

extension Int: StringConvertible {
    var stringValue: String {
        return String(self)
    }
}
