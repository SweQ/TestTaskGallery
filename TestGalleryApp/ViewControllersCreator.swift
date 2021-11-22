//
//  ViewControllersCreator.swift
//  TestGalleryApp
//
//  Created by alexKoro on 15.11.21.
//

import Foundation
import UIKit

class ViewControllerCreator {
    static let shared = ViewControllerCreator()
    private init() { }
    
    func createViewController(identifier: String, storyboardName: String) -> UIViewController {
        let storyboard = getSoryboard(name: storyboardName)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
        return viewController
    }
    
    private func getSoryboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}
