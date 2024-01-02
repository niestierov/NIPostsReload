//
//  CollectionViewLayoutProvider+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 29.12.2023.
//

import UIKit

protocol CollectionViewLayoutProvider {
    func createItem(
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension
    ) -> NSCollectionLayoutItem

    func createVerticalGroup(
        with subitems: [NSCollectionLayoutItem],
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension
    ) -> NSCollectionLayoutGroup

    func createHorizontalGroup(
        with subitems: [NSCollectionLayoutItem],
        width: NSCollectionLayoutDimension,
        height: NSCollectionLayoutDimension
    ) -> NSCollectionLayoutGroup

    func createSection(with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection
}

extension CollectionViewLayoutProvider {
    func createItem(
        width: NSCollectionLayoutDimension = .fractionalWidth(1),
        height: NSCollectionLayoutDimension = .estimated(44)
    ) -> NSCollectionLayoutItem {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: width,
            heightDimension: height
        )
        return NSCollectionLayoutItem(layoutSize: itemSize)
    }

    func createVerticalGroup(
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

    func createHorizontalGroup(
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

    func createSection(with group: NSCollectionLayoutGroup) -> NSCollectionLayoutSection {
        NSCollectionLayoutSection(group: group)
    }
}
