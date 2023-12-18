//
//  UIViewController+Extension.swift
//  NIPostsReload
//
//  Created by Denys Niestierov on 15.12.2023.
//

import UIKit

extension UIViewController {
    struct AlertButtonAction {
        let title: String
        let style: UIAlertAction.Style
        let completion: (() -> Void)?
        
        static func `default`() -> AlertButtonAction {
            AlertButtonAction(
                title: "Okay",
                style: .default,
                completion: nil
            )
        }
    }
    
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
