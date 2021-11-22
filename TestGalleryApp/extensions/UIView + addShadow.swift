//
//  UIView + addShadow.swift
//  TestGalleryApp
//
//  Created by alexKoro on 24.10.21.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(color: UIColor, radius: CGFloat, opacity: Float, offset: CGSize) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
    }
}
