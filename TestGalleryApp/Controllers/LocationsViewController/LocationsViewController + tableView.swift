//
//  LocationsViewController + tableView.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation
import UIKit

extension LocationsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return Profile.shared.albums.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellsIdentifiers.AlbumTableViewCell.rawValue
            ) as? AlbumTableViewCell else {
                return UITableViewCell()
            }
            cell.tag = indexPath.row
            cell.backgroundColor = .clear
            cell.locationTextField.text = Profile.shared.albums[cell.tag].location
            cell.viewController = self
            cell.collectionView.reloadData()
            return cell
            
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellsIdentifiers.CreateAlbumTableViewCell.rawValue
            ) as? CreateAlbumTableViewCell else { return UITableViewCell() }
            cell.backgroundColor = .clear
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let countOfPhoto = Profile.shared.albums[indexPath.row].photosURLs.count
            
            if let height = TableRowSizes.share.getSize(for: countOfPhoto)?.height {
                return height
            } else {
                return UITableView.automaticDimension
            }
        } else {
            return UITableView.automaticDimension
        }
    }
    
}
