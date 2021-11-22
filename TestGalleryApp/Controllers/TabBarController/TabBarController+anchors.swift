//
//  TabBarController+anchors.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation
import UIKit

extension TabBarController {
    func setupBackgroundViewAnchors() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalTo: tabBar.heightAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
            backgroundView.leftAnchor.constraint(equalTo: tabBar.leftAnchor),
            backgroundView.rightAnchor.constraint(equalTo: tabBar.rightAnchor)
        ])
    }
    
    func setupCentralButtonAnchors() {
        centralButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            centralButtonImageView.heightAnchor.constraint(equalTo: tabBar.heightAnchor, multiplier: 1.5),
            centralButtonImageView.widthAnchor.constraint(equalTo: centralButtonImageView.heightAnchor),
            centralButtonImageView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            centralButtonImageView.centerYAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }
}
