//
//  ViewController.swift
//  TestGalleryApp
//
//  Created by alexKoro on 23.10.21.
//

import UIKit

class TabBarController: UITabBarController{
    
    let centralButtonImageView = UIImageView()
    let backgroundView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTabBar()
        setupCentralButton()
        
    }


    func setupView() {
        view.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 1)
    }
    
    func setupTabBar() {
        view.addSubview(backgroundView)
        setupBackgroundViewAnchors()
        backgroundView.addShadow(color: .darkGray, radius: 3, opacity: 0.3, offset: CGSize(width: 0, height: -10))
        backgroundView.addSubview(tabBar)
        backgroundView.backgroundColor = UIColor(red: 35, green: 35, blue: 35, alpha: 0.13)
    }
    
    func setupCentralButton() {
        view.addSubview(centralButtonImageView)
        centralButtonImageView.contentMode = .scaleAspectFit
        centralButtonImageView.image = UIImage(named: .centralButton)
        setupCentralButtonAnchors()
        centralButtonImageView.addShadow(color: .darkGray, radius: 2, opacity: 1, offset: .zero)
    }

}

