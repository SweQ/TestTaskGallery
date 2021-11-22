//
//  AlbumTableCell+anchors.swift
//  TestGalleryApp
//
//  Created by alexKoro on 31.10.21.
//

import Foundation
import UIKit

extension AlbumTableViewCell {

    func createOuterContainerAnchors() {
        outerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            outerContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            outerContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -35),
            outerContainer.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            outerContainer.rightAnchor.constraint(equalTo: contentView.rightAnchor)
        ])
    }
    func createDeleteButtonAnchors() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            deleteButton.heightAnchor.constraint(equalToConstant: 44),
            deleteButton.widthAnchor.constraint(equalTo: outerContainer.widthAnchor, multiplier: 0.5),
            deleteButton.centerXAnchor.constraint(equalTo: outerContainer.centerXAnchor),
            deleteButton.centerYAnchor.constraint(equalTo: outerContainer.bottomAnchor)
        ])
    }
    func createInnerContainerAnchors() {
        innerContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            innerContainer.topAnchor.constraint(equalTo: outerContainer.topAnchor, constant: containerPadding),
            innerContainer.bottomAnchor.constraint(equalTo: outerContainer.bottomAnchor, constant: -containerPadding),
            innerContainer.leftAnchor.constraint(equalTo: outerContainer.leftAnchor, constant: containerPadding),
            innerContainer.rightAnchor.constraint(equalTo: outerContainer.rightAnchor, constant: -containerPadding)
        ])
    }
    
    func createHeaderViewAnchors() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: innerContainer.topAnchor, constant: headerPadding),
            headerView.leftAnchor.constraint(equalTo: innerContainer.leftAnchor, constant: headerPadding),
            headerView.rightAnchor.constraint(equalTo: innerContainer.rightAnchor, constant: -headerPadding),
            headerView.bottomAnchor.constraint(equalTo: collectionView.topAnchor)
        ])
    }
    
    func createLocationTextFieldAnchors() {
        locationTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            locationTextField.topAnchor.constraint(equalTo: addButton.topAnchor),
            locationTextField.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            locationTextField.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -locationTextPadding),
            locationTextField.bottomAnchor.constraint(equalTo: addButton.bottomAnchor)
        ])
    }
    
    func createAddButtonAnchors() {
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: headerView.topAnchor),
            addButton.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            addButton.heightAnchor.constraint(equalToConstant: addButtonHeight),
            addButton.widthAnchor.constraint(equalTo: addButton.heightAnchor),
            addButton.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
        ])
    }
    
    func createCollectionViewAnchors() {
        collectionViewHeightConstraint = collectionView.heightAnchor.constraint(equalToConstant: 0)
        collectionViewHeightConstraint.priority = UILayoutPriority(999)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: headerView.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: headerView.rightAnchor),
            collectionViewHeightConstraint,
            collectionView.bottomAnchor.constraint(equalTo: innerContainer.bottomAnchor, constant: -collectionPadding)
        ])
    }
    
}
