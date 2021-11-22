//
//  AuthViewController+anchors.swift
//  TestGalleryApp
//
//  Created by alexKoro on 15.11.21.
//

import Foundation
import UIKit

extension AuthViewController {
    func setupEmailTextFieldAnchors() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
        ])
    }
    
    func setupPasswordTextFieldAnchors() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: view.centerYAnchor, constant: -10),
            passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor),
            passwordTextField.centerXAnchor.constraint(equalTo: emailTextField.centerXAnchor)
        ])
    }
    
    func setupEnterButtonAnchors() {
        enterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            enterButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            enterButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor, multiplier: 0.6),
            enterButton.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor)
        ])
    }
    
    func setupRegisterButtonAnchors() {
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: enterButton.bottomAnchor, constant: 20),
            registerButton.widthAnchor.constraint(equalTo: enterButton.widthAnchor),
            registerButton.centerXAnchor.constraint(equalTo: enterButton.centerXAnchor),
            registerButton.heightAnchor.constraint(equalTo: enterButton.heightAnchor)
        ])
    }
}
