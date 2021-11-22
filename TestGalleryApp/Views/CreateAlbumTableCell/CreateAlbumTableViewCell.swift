//
//  CreateAlbumTableViewCell.swift
//  TestGalleryApp
//
//  Created by alexKoro on 27.10.21.
//

import UIKit

class CreateAlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var createButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCreateButton()
    }
    
    func setupCreateButton() {
        createButton.translatesAutoresizingMaskIntoConstraints = false
        
        createButton.addShadow(color: .darkGray, radius: 5, opacity: 0.5, offset: CGSize(width: -5, height: 5))
        
        NSLayoutConstraint.activate([
            createButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            createButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            createButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
            createButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 50),
            createButton.widthAnchor.constraint(equalTo: createButton.heightAnchor)
        ])
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
        guard let newAlbumId = FirebaseManager.shared.createNewAlbum(with: "Название локации") else {
            print("Error create new album.")
            return
        }
        Profile.shared.albums.append(Album(id: newAlbumId, location: "Название локации", photosURLs: []))
        guard let tableView = self.superview as? UITableView else { return }
        tableView.reloadData()
        tableView.scrollToRow(at: IndexPath(row: 0, section: 1), at: .bottom, animated: true)
    }
}
