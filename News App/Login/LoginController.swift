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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        _view.continueButton.addTarget(self, action: #selector(loginHandler), for: .primaryActionTriggered)
    }
    
    @objc func loginHandler() {
        
        if let email = _view.emailField.text, let password = _view.passwordField.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
                guard let self = self else { return }
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.navigationController?.pushViewController(ViewController(), animated: true)
                }
            }
        }
    }

    
}

