//
//  UICollectionView+Reusable.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

extension UITableViewCell: SelfIdentifiable { }

extension UITableView {
    func register(_ cellType: SelfIdentifiable.Type) {
        register(cellType.self, forCellReuseIdentifier: cellType.identifier)
    }

    func dequeue<T: SelfIdentifiable>(cellType: T.Type, at indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: cellType.identifier, for: indexPath) as! T
    }
}
