//
//  UICollectionView+Reusable.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 06.12.2023.
//

import UIKit

extension UICollectionViewCell: StringIdentifiable { }

extension UICollectionView {
    func register(_ cellType: StringIdentifiable.Type) {
        register(cellType.self, forCellWithReuseIdentifier: cellType.identifier)
    }

    func dequeue<T: StringIdentifiable>(cellType: T.Type, at indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! T
    }
}
