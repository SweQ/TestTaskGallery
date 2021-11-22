//
//  SomeModel.swift
//  TestGalleryApp
//
//  Created by alexKoro on 25.10.21.
//

import Foundation
import UIKit

class Profile {
    static let shared = Profile()
    
    private init() { }
    
    var albums: [Album] = []
    var user: User?
}
