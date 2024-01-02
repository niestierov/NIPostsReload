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
    
    func applyPriority(
        contentHuggingPriority: UILayoutPriority = .required,
        contentHuggingAxis: NSLayoutConstraint.Axis = .vertical,
        contentCompressionResistancePriority : UILayoutPriority = .required,
        contentCompressionResistanceAxis: NSLayoutConstraint.Axis = .vertical
    ) {
        self.setContentHuggingPriority(
            contentHuggingPriority,
            for: contentHuggingAxis
        )
        self.setContentCompressionResistancePriority(
            contentCompressionResistancePriority,
            for: contentCompressionResistanceAxis
        )
    }
}
