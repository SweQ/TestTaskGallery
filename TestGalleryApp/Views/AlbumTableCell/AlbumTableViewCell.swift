//
//  AlbumTableViewCell.swift
//  TestGalleryApp
//
//  Created by alexKoro on 25.10.21.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    @IBOutlet weak var outerContainer: UIView!
    @IBOutlet weak var innerContainer: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var deleteButton: UIButton!
    
    let containerPadding: CGFloat = 15
    let outerContainerBottomPadding: CGFloat = 20
    let headerPadding: CGFloat = 10
    let addButtonHeight: CGFloat = 30
    let collectionPadding: CGFloat = 10
    let locationTextPadding: CGFloat = 10
    let minimumSpacingForSection = 5
    var collectionViewHeightConstraint: NSLayoutConstraint!
    
    weak var viewController: UIViewController?
    private var photosForDelete: [String] = []
    
    var isEditingMode = false
    
    var model: Profile = {
        return Profile.shared
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "PhotoCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PhotoCell")
        
        setupCollectionView()
        setupHeaderView()
        setupLocationTextField()
        setupAddButton()
        setupOuterContainer()
        setupInnerContainer()
        setupDeleteButton()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupOuterContainer() {
        outerContainer.layer.cornerRadius = 10
        outerContainer.addShadow(color: .darkGray, radius: 5, opacity: 0.4, offset: CGSize(width: -10, height: 10))
        createOuterContainerAnchors()
    }
    
    func setupInnerContainer() {
        innerContainer.layer.cornerRadius = 10
        createInnerContainerAnchors()
    }
    
    func setupHeaderView() {
        createHeaderViewAnchors()
    }
    
    func setupLocationTextField() {
        locationTextField.delegate = self
        createLocationTextFieldAnchors()
    }
    
    func setupAddButton() {
        createAddButtonAnchors()
    }
    
    func setupDeleteButton() {
        deleteButton.layer.borderColor = UIColor.white.cgColor
        deleteButton.layer.borderWidth = 2
        deleteButton.layer.cornerRadius = 22
        deleteButton.addShadow(color: .darkGray, radius: 5, opacity: 0.4, offset: CGSize(width: -5, height: 5))
        createDeleteButtonAnchors()
    }
    
    func setupCollectionView() {
        createCollectionViewAnchors()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "photoCell")
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        if !photosForDelete.isEmpty {
            FirebaseManager.shared.deletePhoto(album: Profile.shared.albums[tag], photosURLs: photosForDelete)
            guard let tableView = self.superview as? UITableView else { return }
            tableView.reloadRows(at: [IndexPath(row: tag, section: 0)], with: .automatic)
            isEditingMode = false
            updateTable()
        }
    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        guard let vc = viewController as? LocationsViewController else { return }
        vc.showImagePicker(from: tag)
    }
}
//MARK: -UITEXTFIELD DELEGATE
extension AlbumTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let album = Profile.shared.albums[tag]
        guard let newLocation = textField.text,
                album.location != newLocation else { return true }
        FirebaseManager.shared.updateLocation(album: album, location: newLocation)
        textField.resignFirstResponder()
        return true
    }
    
}

//MARK: -COLLECTIONVIEW DELEGATES
extension AlbumTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    override func prepareForReuse() {
        isEditingMode = false
        deleteButton.isHidden = true
        photosForDelete = []
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isEditingMode {
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
            if photosForDelete.contains(Profile.shared.albums[tag].photosURLs[indexPath.item]) {
                cell.deleteImageView.image = UIImage(systemName: "circle")
                photosForDelete.removeAll { $0 == Profile.shared.albums[tag].photosURLs[indexPath.item] }
            } else {
                cell.deleteImageView.image = UIImage(systemName: "checkmark.circle")
                let photoURL = Profile.shared.albums[tag].photosURLs[indexPath.item]
                photosForDelete.append(photoURL)
            }
        } else {
            openImage(indexPath: indexPath)
        }
    }
    
    func openImage(indexPath: IndexPath) {
        guard let viewController = viewController as? LocationsViewController else { return }
        var photo = UIImage(systemName: "pencil")
        let url = Profile.shared.albums[tag].photosURLs[indexPath.item]
        
        if let img = CacheManager.shared.cache.object(forKey: NSString(string: url)) {
            DispatchQueue.main.async {
                photo = img
                viewController.openPhotoOnFullScreen(photo: photo!)
            }
        } else {
            guard let img = FirebaseManager.shared.getPhoto(urlString: url) else { return }
            CacheManager.shared.cache.setObject(img, forKey: NSString(string: url))
            DispatchQueue.main.async {
                viewController.openPhotoOnFullScreen(photo: photo!)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.albums[tag].photosURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        
        cell.imageView.contentMode = .scaleToFill
        cell.imageView.image = UIImage(systemName: "pencil")
        cell.imageView.clipsToBounds = true
        cell.layer.cornerRadius = 10
        cell.tag = indexPath.item
        cell.deleteImageView.isHidden = !isEditingMode
        let tag = self.tag
        
        DispatchQueue.global().async {
            guard Profile.shared.albums[tag].photosURLs.count > indexPath.item else { return }
            let url = Profile.shared.albums[tag].photosURLs[indexPath.item]

            if let img = CacheManager.shared.cache.object(forKey: NSString(string: url)) {
                DispatchQueue.main.async {
                    cell.imageView.image = img
                }
            } else {
                guard let img = FirebaseManager.shared.getPhoto(urlString: url) else { return }
                CacheManager.shared.cache.setObject(img, forKey: NSString(string: url))
                DispatchQueue.main.async {
                    if cell.tag == indexPath.item {
                        cell.imageView.image = img
                    }
                }
            }
        }
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressGestureHandler(sender:)))
        gesture.minimumPressDuration = 3
        cell.addGestureRecognizer(gesture)
        return cell
    }
    
    @objc func longPressGestureHandler(sender: UILongPressGestureRecognizer) {
        if sender.state == .began {
            isEditingMode = !isEditingMode
            deleteButton.isHidden = !isEditingMode
            photosForDelete = []
            collectionView.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.bounds.width - CGFloat(minimumSpacingForSection) * 2) / 3
        let height = width
        collectionViewHeightConstraint.constant = height
        
        if TableRowSizes.share.forZeroPhotos == nil {
            TableRowSizes.share.forZeroPhotos = self.frame.size
            TableRowSizes.share.forLessThanFourPhotos = CGSize(width: self.frame.size.width, height: self.frame.height + collectionViewHeightConstraint.constant)
            TableRowSizes.share.forMoreThanThreePhotos = CGSize(width: self.frame.size.width, height: self.frame.height + collectionViewHeightConstraint.constant * 2 + CGFloat(minimumSpacingForSection))
        }
        
        return CGSize(width: width, height: height)
    }
    
    func updateTable() {
        guard let table = self.superview as? UITableView else { return }
        table.beginUpdates()
        table.endUpdates()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumSpacingForSection)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(minimumSpacingForSection)
    }

}
