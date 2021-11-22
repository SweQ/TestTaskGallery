//
//  PhotoCell.swift
//  TestGalleryApp
//
//  Created by alexKoro on 1.11.21.
//

import UIKit

class PhotoCell: UICollectionViewCell {

    @IBOutlet weak var deleteImageView: UIImageView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
        setupDeleteImageView()
        deleteImageView.isHidden = true
    }

    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    
    func setupDeleteImageView() {
        deleteImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            deleteImageView.widthAnchor.constraint(equalTo: deleteImageView.heightAnchor),
            deleteImageView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            deleteImageView.rightAnchor.constraint(equalTo: imageView.rightAnchor, constant: -10)
        ])
    }
}
