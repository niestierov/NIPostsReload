//
//  UILabel+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 13.12.2023.
//

import UIKit

extension UILabel {
    func doesTextFitInLines() -> Bool {
        guard let text = self.text,
              let font = self.font else {
            return false
        }

        let rectSize = CGSize(
            width: self.frame.size.width,
            height: .greatestFiniteMagnitude
        )
        let boundingRect = text.boundingRect(
            with: rectSize,
            options: .usesLineFragmentOrigin,
            attributes: [NSAttributedString.Key.font: font],
            context: nil
        )

        let calculatedLines = Int(boundingRect.height / font.lineHeight) - 1

        return calculatedLines <= self.numberOfLines
    }
}


