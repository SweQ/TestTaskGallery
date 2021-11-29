//
//  LocationViewController + imagePickerDelegate.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation
import UIKit

extension LocationsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        guard let img = info[.editedImage] as? UIImage,
        let tag = albumTagForUploadImage
        else {
            print(Errors.imagePickerController)
            return
        }
        FirebaseManager.shared.uploadPhoto(
            photo: img,
            tag: tag
        ) { [weak self] in
                self?.tableView.reloadData()
            }
        picker.dismiss(animated: true)
    }
    
}
