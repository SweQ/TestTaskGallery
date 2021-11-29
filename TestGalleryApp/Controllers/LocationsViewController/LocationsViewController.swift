//
//  LocationsViewController.swift
//  TestGalleryApp
//
//  Created by alexKoro on 24.10.21.
//

import UIKit
import Firebase
import FirebaseStorage

class LocationsViewController: UIViewController {

    @IBOutlet weak var headerView: HeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    //need refactoring this var
    var albumTagForUploadImage: Int?
    
    var tableViewBottomAnchor: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTable()
    }
//MARK: -Observers
    func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHandler(info:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideHandler(info: )),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShowHandler(info: Notification) {
        guard let size = info.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
        else {
            return
        }
        tableViewBottomAnchor?.constant = -size.height
    }

    @objc func keyboardWillHideHandler(info: Notification) {
        tableViewBottomAnchor?.constant = 0
    }
    
    @objc func tapGestureHandler(sender: UITapGestureRecognizer) {
        sender.view?.removeFromSuperview()
    }
//MARK: -Load table
    func loadTable() {
        DispatchQueue.global().async {
            FirebaseManager.shared.getAlbums {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.beginUpdates()
                    self.tableView.endUpdates()
                }
            }
        }
    }
//MARK: -Setup ui elements
    func setupHeaderView() {
        setupHeaderViewAnchors()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        setupTableViewAnchors()
        
        let albumCellNib = UINib(
            nibName: NibNames.AlbumTableViewCell.rawValue,
            bundle: nil
        )
        let createCellNib = UINib(
            nibName: NibNames.CreateAlbumTableViewCell.rawValue,
            bundle: nil
        )
        tableView.register(
            albumCellNib,
            forCellReuseIdentifier: CellsIdentifiers.AlbumTableViewCell.rawValue
        )
        tableView.register(
            createCellNib,
            forCellReuseIdentifier: CellsIdentifiers.CreateAlbumTableViewCell.rawValue
        )
    }
//MARK: -Actions
    func showImagePicker(from cellTag: Int) {
        albumTagForUploadImage = cellTag
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openPhotoOnFullScreen(photo: UIImage) {
        let imageView = UIImageView()
        imageView.image = photo
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.frame = view.frame
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(
            UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureHandler(sender:))
            )
        )
        view.addSubview(imageView)
    }
}

