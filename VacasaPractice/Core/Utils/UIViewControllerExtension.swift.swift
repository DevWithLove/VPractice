//
//  UIViewControllerExtension.swift.swift
//  VacasaPractice
//
//  Created by Tony Mu on 24/12/21.
//

import UIKit

extension UIViewController {
    func presentMessage(message: String, title: String = "", completion:(()->Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alertController.addAction(okAction)
        alertController.present(self, animated: true, completion: completion)
    }
}

