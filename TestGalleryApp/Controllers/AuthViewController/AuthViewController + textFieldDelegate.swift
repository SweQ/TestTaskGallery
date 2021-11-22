//
//  AuthViewController + textFieldDelegate.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation
import UIKit

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
