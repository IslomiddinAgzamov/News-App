//
//  SettingsController.swift
//  News App
//
//  Created by Islomiddin on 25/08/22.
//

import UIKit
import Firebase

class SettingsController: UIViewController {
    
    let _view = SettingsView()
    
    override func loadView() {
        view = _view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rightBarItem = UIBarButtonItem(title: "LogOut", style: .plain, target: self, action: #selector(logOutHandler))
        rightBarItem.tintColor = .red
        
        navigationItem.title = "Settings"
        navigationItem.rightBarButtonItem = rightBarItem
        
        _view.saveButton.addTarget(self, action: #selector(saveButtonHandler), for: .primaryActionTriggered)
    }
    
    @objc func saveButtonHandler() {
        
        let user = Auth.auth().currentUser
        guard let newEmail = _view.emailField.text, let newPassword = _view.passwordField.text else { return }
        
        user?.updateEmail(to: newEmail)
        user?.updatePassword(to: newPassword)
        
        navigationController?.popViewController(animated: true)
    }
    
    @objc func logOutHandler() {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch {
            print("Error signing out \(error)")
        }
    }

}
