//
//  RegistrationController.swift
//  News App
//
//  Created by Islomiddin on 24/08/22.
//

import UIKit
import Firebase

class RegistrationController: UIViewController {

    let _view = RegistrationView()
    
    override func loadView() {
        view = _view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        _view.continueButton.addTarget(self, action: #selector(registrationHandler), for: .primaryActionTriggered)
    }
    
    @objc func registrationHandler() {
        
        if let email = _view.emailField.text, let password = _view.passwordField.text {
            Auth.auth().createUser(withEmail: email, password: password) { _, error in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    self.navigationController?.pushViewController(ViewController(), animated: true)
                }
            }
        }
    }

}
