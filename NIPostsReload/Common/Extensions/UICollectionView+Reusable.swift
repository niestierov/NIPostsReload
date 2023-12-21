//
//  UICollectionView+Reusable.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

extension UITableViewCell: StringIdentifiable { }

extension UITableView {
    func register(_ cellType: StringIdentifiable.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }

    func dequeue<T: StringIdentifiable>(cellType: T.Type, at indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! T
    }
}
