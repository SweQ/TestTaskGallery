//
//  ScreenManager.swift
//  TestGalleryApp
//
//  Created by alexKoro on 15.11.21.
//

import Foundation
import UIKit

class ScreenManager {
    static let shared = ScreenManager()
    private init() { }
    
    func setRoot(viewController: UIViewController) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows.first?.rootViewController = viewController
    }
}
