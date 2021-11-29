//
//  FirebaseManager.swift
//  TestGalleryApp
//
//  Created by alexKoro on 2.11.21.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore
import UIKit

class FirebaseManager{
    let refFirestoreAlbums = Firestore.firestore().collection(FirebaseCollections.albums.rawValue)
    let refFirestoreUsers = Firestore.firestore().collection(FirebaseCollections.users.rawValue)
    let refStorage = Storage.storage().reference().child(FirebaseCollections.photos.rawValue)
    static let shared = FirebaseManager()
    
    var almubsTags: [String] = []
    
    func createNewUser(with id: String) {
        let userDocument = refFirestoreUsers.document()
        refFirestoreUsers.document(userDocument.documentID).setData([
            FirebaseFields.id.rawValue: id
        ])
    }
    
    func createNewAlbum(with location: String) -> String? {
        guard let user = Profile.shared.user else {
            print(Errors.createNewAlbum)
            return nil
        }
        let albumDocument = refFirestoreAlbums.document()
        refFirestoreAlbums.document(albumDocument.documentID).setData([
            FirebaseFields.dataCreate.rawValue: Date().timeIntervalSince1970,
            FirebaseFields.photosURLs.rawValue: [String](),
            FirebaseFields.location.rawValue: location,
            FirebaseFields.owner.rawValue: user.id
        ])
        return albumDocument.documentID
    }
    
    func addPhotoInAlbum(album: String, photo url: String) {
        refFirestoreAlbums.document(album).updateData([
            FirebaseFields.photosURLs.rawValue: FieldValue.arrayUnion([url])
        ])
    }
    
    func updateLocation(album: Album, location: String) {
        album.location = location
        refFirestoreAlbums.document(album.id).updateData([
            FirebaseFields.location.rawValue: location
        ])
    }

   func getAlbums(loadPhotosCompletion: @escaping () -> ()) {
       guard let userId = Profile.shared.user?.id else {
           print(Errors.getAlbums)
           return
       }
       let dg = DispatchGroup()
       dg.enter()
       refFirestoreAlbums.whereField(
        FirebaseFields.owner.rawValue,
        isEqualTo: userId
       ).order(
        by: FirebaseFields.dataCreate.rawValue
       ).getDocuments { snapshot, error in
           if let error = error {
               print("\(Errors.getAlbums): \(error.localizedDescription)")
               return
           }
           guard let snapshot = snapshot else {
               print(Errors.getAlbums)
               return
           }
           
           for document in snapshot.documents {
               let album = Album(id: document.documentID, location: "", photosURLs: [])
               Profile.shared.albums.append(album)
               
               guard let photosURLs = document.data()[FirebaseFields.photosURLs.rawValue] as? [String],
                     let location = document.data()[FirebaseFields.location.rawValue] as? String
               else {
                   print(Errors.getAlbums)
                   return
               }
               Profile.shared.albums.first { album in
                   return album.id == document.documentID
               }?.location = location
               Profile.shared.albums.first { album in
                   return album.id == document.documentID
               }?.photosURLs = photosURLs
               document.data()
           }
           dg.leave()
       }
       dg.notify(queue: .main) {
           loadPhotosCompletion()
       }
   }

    func getPhoto(urlString: String) -> UIImage? {
        guard let url = URL(string: urlString) else {
            print(Errors.getPhoto)
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            print(Errors.getPhoto)
            return nil
        }
        guard let image = UIImage(data: data) else
        {
            print(Errors.getPhoto)
            return nil
        }
        
        return image
    }
    
    func deletePhoto(album: Album, photosURLs: [String]) {
        for urlString in photosURLs {
            guard let url = URL(string: urlString) else { return }
            album.photosURLs = album.photosURLs.filter({ $0 != urlString })
            refStorage.child(url.lastPathComponent).delete { error in
                if let error = error {
                    print("\(Errors.deletePhoto): \(error.localizedDescription)")
                }
            }
        }
        
        refFirestoreAlbums.document(album.id).updateData([
            FirebaseFields.photosURLs.rawValue: album.photosURLs
        ])
    }
    
    func uploadPhoto(photo: UIImage, tag: Int, completion: (()->())?) {
        DispatchQueue.global().async { [weak self] in
            self?.addPhotoToStorage(photo: photo) { urlString in
                FirebaseManager.shared.addPhotoInAlbum(
                    album: Profile.shared.albums[tag].id,
                    photo: urlString
                )
                CacheManager.shared.imagesCache.setObject(
                    photo,
                    forKey: NSString(string: urlString)
                )
                Profile.shared.albums[tag].photosURLs.append(urlString)
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    func addPhotoToStorage(photo: UIImage, completion: @escaping (String)->()) {
        let ref = refStorage.child(UUID().uuidString)
        guard let imageData = photo.jpegData(compressionQuality: 1.0) else {
            return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        ref.putData(imageData, metadata: metadata) { metadata, error in
            if let error = error {
                print("\(Errors.addPhotoToStorage): \(error.localizedDescription)")
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    print("\(Errors.addPhotoToStorage): \(error.localizedDescription)")
                    return
                }
                guard let url = url else {
                    print(Errors.addPhotoToStorage)
                    return
                }
                completion("\(url)")
            }
        }
    }

}
