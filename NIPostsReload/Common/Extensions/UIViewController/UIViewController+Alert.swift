//
//  UIViewController+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 15.12.2023.
//

import UIKit

struct AlertButtonAction {
    let title: String
    let style: UIAlertAction.Style
    let completion: EmptyBlock?
    
    static func `default`() -> AlertButtonAction {
        AlertButtonAction(
            title: "Okay",
            style: .default,
            completion: nil
        )
    }
}

struct AlertConstant {
    static let defaultAlertErrorTitle = "Error"
    static let defaultAlertErrorMessage = "Something went wrong..."
}

extension UIViewController {
    func showAlert(
        title: String,
        message: String,
        actions: [AlertButtonAction]? = nil
    ) {
        let alertController = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let alertActions = actions ?? [AlertButtonAction.default()]
        
        alertActions.forEach { action in
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                action.completion?()
            }
            alertController.addAction(alertAction)
        }
        
        present(alertController, animated: true, completion: nil)
    }
}
