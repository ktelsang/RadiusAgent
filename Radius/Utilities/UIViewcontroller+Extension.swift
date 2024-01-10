//
//  UIViewcontroller+Extension.swift
//  Radius
//
//  Created by Kavyashree Hegde on 29/06/23.
//

import UIKit

extension UIViewController {
    func showAlert(withTitle title: String,
                   withMessage message: String,
                   handler: ((UIAlertAction) -> Void)?) {
        let updatedTitle = title == "" ? nil : title
        let alert = UIAlertController(title: updatedTitle, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .cancel, handler: handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}
