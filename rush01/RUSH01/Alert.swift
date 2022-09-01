//
//  Alert.swift
//  RUSH01
//
//  Created by Zuleykha Pavlichenkova on 24.08.2022.
//

import UIKit

extension UIViewController {
    func alertAddAddress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default) { (action) in
            print("action")
            
            let textFieldText = alertController.textFields?.first
            guard let text = textFieldText?.text else {return}
            completionHandler(text)
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default) { (_) in
            
        }
        
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func alertError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOK = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(alertOK)
        
        present(alertController, animated: true, completion: nil)
    }
}
