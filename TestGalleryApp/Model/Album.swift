//
//  Album.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation

class Album {
    var id: String
    var location: String
    var photosURLs: [String]
    var owner: User?
    
    init(id: String, location: String, photosURLs: [String]) {
        self.id = id
        self.location = location
        self.photosURLs = photosURLs
        self.owner = Profile.shared.user
    }
}
