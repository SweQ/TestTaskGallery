//
//  HeaderView.swift
//  TestGalleryApp
//
//  Created by alexKoro on 23.10.21.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var backgroungImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        Bundle.init(for: HeaderView.self).loadNibNamed(String(describing: HeaderView.self), owner: self, options: nil)
        setupContainerView()
        setupBackgroundImageView()
        setupTitleLabel()
    }
    
    private func setupContainerView() {
        self.addSubview(containerView)
        self.fixInContainer(view: containerView)
    }
    
    private func setupBackgroundImageView() {
        backgroungImageView.translatesAutoresizingMaskIntoConstraints = false
        
        backgroungImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        backgroungImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        backgroungImageView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        backgroungImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
    }
    
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.leftAnchor.constraint(equalTo: backgroungImageView.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: backgroungImageView.rightAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: backgroungImageView.bottomAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: backgroungImageView.topAnchor).isActive = true
    }

}
