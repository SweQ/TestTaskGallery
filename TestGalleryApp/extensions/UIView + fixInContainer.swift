//
//  UIView + fixInContainer.swift
//  TestGalleryApp
//
//  Created by alexKoro on 23.10.21.
//

import Foundation
import UIKit

extension UIView {
    func fixInContainer(view: UIView) {
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false

        view.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
}
