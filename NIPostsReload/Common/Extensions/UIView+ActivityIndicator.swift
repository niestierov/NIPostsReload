//
//  UIView+ActivityIndicator.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 29.12.2023.
//

import UIKit

extension UIView {
    private var activityIndicatorTag: Int {
        return 999
    }

    func showActivityIndicator(
        style: UIActivityIndicatorView.Style = .medium,
        position: CGPoint? = nil
    ) {
        if viewWithTag(activityIndicatorTag) == nil {
            let activityIndicator = UIActivityIndicatorView(style: style)
            activityIndicator.tag = activityIndicatorTag
            activityIndicator.center = position ?? center
            activityIndicator.startAnimating()
            addSubview(activityIndicator)
        }
    }

    func hideActivityIndicator() {
        if let activityIndicator = viewWithTag(activityIndicatorTag) as? UIActivityIndicatorView {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
