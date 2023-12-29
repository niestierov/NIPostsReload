//
//  UIViewController+CompositionalLayout.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 29.12.2023.
//

import UIKit

extension UIViewController {
    func createCollectionViewItem(
        width: NSCollectionLayoutDimension = .fractionalWidth(1),
        height: NSCollectionLayoutDimension = .estimated(44)
    ) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }

    func createCollectionViewVerticalGroup(
        with subitems: [NSCollectionLayoutItem],
        width: NSCollectionLayoutDimension = .fractionalWidth(1),
        height: NSCollectionLayoutDimension = .estimated(44)
    ) -> NSCollectionLayoutGroup {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        return NSCollectionLayoutGroup.vertical(
            layoutSize: layoutSize,
            subitems: subitems
        )
    }
    
    func createCollectionViewHorizontalGroup(
        with subitems: [NSCollectionLayoutItem],
        width: NSCollectionLayoutDimension = .fractionalWidth(1),
        height: NSCollectionLayoutDimension = .estimated(44)
    ) -> NSCollectionLayoutGroup {
        let layoutSize = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        return NSCollectionLayoutGroup.horizontal(
            layoutSize: layoutSize,
            subitems: subitems
        )
    }

    func createCollectionViewSection(with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        NSCollectionLayoutSection(group: group)
    }
}
