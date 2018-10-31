//
//  UIViewController+AlertMessages.swift
//  phuza
//
//  Created by Stanislau Sakharchuk on 31/10/2018.
//  Copyright © 2018 phuza. All rights reserved.
//

import UIKit

extension UIViewController {
    func showMessage(_ message: String?, title: String?, action: UIAlertAction? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let action = action {
            alertController.addAction(action)
        } else {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        }
        present(alertController, animated: true, completion: nil)
    }
}
