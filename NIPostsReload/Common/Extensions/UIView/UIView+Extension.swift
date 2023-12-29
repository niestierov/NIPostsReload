//
//  UIView+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 26.12.2023.
//

import UIKit

extension UIView {
    func applyRoundedCorners(
        cornerRadius: CGFloat = 15,
        cornerCurve: CALayerCornerCurve = .continuous
    ) {
        self.layer.cornerRadius = cornerRadius
        self.layer.cornerCurve = cornerCurve
    }
}
