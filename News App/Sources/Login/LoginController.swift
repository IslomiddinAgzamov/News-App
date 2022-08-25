//
//  LoginController.swift
//  News App
//
//  Created by Islomiddin on 23/08/22.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    let _view = LoginView()
    
    override func loadView() {
        view = _view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let user = Auth.auth().currentUser
        
        if user != nil {
            navigationController?.pushViewController(NewsController(), animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        _view.continueButton.addTarget(self, action: #selector(loginHandler), for: .primaryActionTriggered)
        _view.registrationButton.addTarget(self, action: #selector(toRegistration), for: .primaryActionTriggered)
    }
    
    @objc func loginHandler() {
        
        if let email = _view.emailField.text, let password = _view.passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
                guard let self = self else { return }
                if let e = error {
                    print(e.localizedDescription)
                    self._view.errorLabel.isHidden = false
                } else {
                    self.navigationController?.pushViewController(NewsController(), animated: true)
                    self._view.emailField.text = nil
                    self._view.passwordField.text = nil
                    self._view.errorLabel.isHidden = true
                }
            }
        }
    }
    
    @objc func toRegistration() {
        navigationController?.pushViewController(RegistrationController(), animated: true)
    }
    
}

