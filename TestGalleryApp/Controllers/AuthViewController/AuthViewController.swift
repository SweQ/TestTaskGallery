//
//  AuthViewController.swift
//  TestGalleryApp
//
//  Created by alexKoro on 14.11.21.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupEmailTextField()
        setupPasswordTextField()
        setupEnterButton()
        setupRegisterButton()
        setupObservers()
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShowHandler(info:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHideHandler(info:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShowHandler(info: Notification) {
        guard let size = info.userInfo?["UIKeyboardFrameEndUserInfoKey"] as? CGRect
        else {
            return
        }
        view.frame.origin.y = -size.height / 2
    }
    
    @objc func keyboardWillHideHandler(info: Notification) {
        view.frame.origin.y = 0
    }
    
    func setupEmailTextField() {
        emailTextField.delegate = self
        setupEmailTextFieldAnchors()
    }
    
    func setupPasswordTextField() {
        passwordTextField.delegate = self
        setupPasswordTextFieldAnchors()
    }
    
    func setupEnterButton() {
        setupEnterButtonAnchors()
    }
    
    func setupRegisterButton() {
        setupRegisterButtonAnchors()
    }
    
    func enterToApp(email: String?, password: String?, type: AuthType) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else {
            let alert = AlertCreator.shared.createAlert(title: "Error", message: "Need correct email and password.")
            present(alert, animated: true, completion: nil)
            return
        }
        
        switch type {
        case .signIn:
            signIn(email: email, password: password)
        case .register:
            createNewUser(email: email, password: password)
        }
    }
    
    func createNewUser(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            guard let result = result
            else {
                if let error = error {
                    self?.showAlert(
                        title: "Error",
                        message: error.localizedDescription
                    )
                }
                return
            }
            FirebaseManager.shared.createNewUser(with: result.user.uid)
            self?.setupUser(id: result.user.uid)
            self?.showMainScreen()
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            guard let result = result
            else {
                if let error = error {
                    self?.showAlert(
                        title: "Error",
                        message: error.localizedDescription
                    )
                }
                return
            }
            self?.setupUser(id: result.user.uid)
            self?.showMainScreen()
        }
    }
    
    func setupUser(id: String) {
        Profile.shared.user = User(id: id)
    }
    
    func showAlert(title: String, message: String) {
        let alert = AlertCreator.shared.createAlert(
            title: title,
            message: message
        )
        self.present(alert, animated: true, completion: nil)
    }
    
    func showMainScreen() {
        let viewController = ViewControllerCreator.shared.createViewController(
            identifier: ControllersIdentifier.mainViewController.rawValue,
            storyboardName: StoryboardsIdentifiers.main.rawValue
        )
        ScreenManager.shared.setRoot(viewController: viewController)
    }
    
    @IBAction func enterButtonPressed(_ sender: UIButton) {
        enterToApp(
            email: emailTextField.text,
            password: passwordTextField.text,
            type: .signIn
        )
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        enterToApp(
            email: emailTextField.text,
            password: passwordTextField.text,
            type: .register
        )
    }
    
}


