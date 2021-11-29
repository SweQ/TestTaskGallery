//
//  ChacheManager.swift
//  TestGalleryApp
//
//  Created by alexKoro on 3.11.21.
//

import Foundation
import UIKit

class CacheManager {
    static let shared = CacheManager()
    var imagesCache = NSCache<NSString, UIImage>()
}
