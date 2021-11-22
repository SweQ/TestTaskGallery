//
//  AlertCreator.swift
//  TestGalleryApp
//
//  Created by alexKoro on 15.11.21.
//

import Foundation
import UIKit

class AlertCreator {
    static let shared = AlertCreator()
    private init() { }
    
    func createAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return alert
    }
    
    func alertForBadEmailOrPassword() -> UIAlertController {
        return createAlert(title: "Error", message: "Need correct email and password.")
    }
}
