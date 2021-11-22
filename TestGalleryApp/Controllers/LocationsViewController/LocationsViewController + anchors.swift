//
//  LocationsViewController + anchors.swift
//  TestGalleryApp
//
//  Created by alexKoro on 18.11.21.
//

import Foundation
import UIKit

extension LocationsViewController {
    func setupHeaderViewAnchors() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10)
        ])
    }
    
    func setupTableViewAnchors() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //bottomAnchor need when we call keyboard
        tableViewBottomAnchor = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableViewBottomAnchor!
        ])
    }
}
