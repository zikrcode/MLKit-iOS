//
//  UIViewController+Extensions.swift
//  ML Kit
//
//  Created by Zokirjon Mamadjonov on 14/07/2023.
//

import UIKit

extension UIViewController {
    func showAlert(error: String, title: String, message: String) {
        let errorMessage = String(format: "barcode_scan_error_message".localized, error)
        let errorAlertController = UIAlertController(
            title: title,
            message: errorMessage,
            preferredStyle: .actionSheet
        )
        
        let okAction = UIAlertAction(title: "ok".localized, style: .destructive)
        errorAlertController.addAction(okAction)
        
        present(errorAlertController, animated: true)
    }
}
