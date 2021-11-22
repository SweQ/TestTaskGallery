//
//  UIImage + init.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation
import UIKit

extension UIImage {
    convenience init? (named: AppImages) {
        self.init(named: named.rawValue)
    }
}
