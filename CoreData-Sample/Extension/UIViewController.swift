//
//  UIViewController.swift
//  CoreData-Sample
//
//  Created by Javid Museyibli on 10/15/19.
//  Copyright © 2019 Javid Museyibli. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String, actionTitle: String, actionStyle: UIAlertAction.Style, handler: @escaping ((UIAlertAction) -> Void), completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: actionStyle, handler: handler)
        alertController.addAction(action)
        present(alertController, animated: true, completion: completion)
    }
}
