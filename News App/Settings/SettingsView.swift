//
//  SettingsView.swift
//  News App
//
//  Created by Islomiddin on 25/08/22.
//

import UIKit
import Firebase

class SettingsView: UIView {

    let fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    let myProfileLabel: UILabel = {
        let label = UILabel()
        label.text = "My Profile Info"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Change Email"
        field.keyboardType = .emailAddress
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 20
        return field
    }()
    
    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Change Password"
        field.isSecureTextEntry = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 20
        return field
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.setTitle("Save", for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 20
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        style()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func style() {
        
        backgroundColor = .white
        
        let user = Auth.auth().currentUser
        emailField.text = user?.email
    }
    
    private func configureUI() {
        
        addSubview(fieldStack)
        addSubview(saveButton)
        
        fieldStack.addArrangedSubview(myProfileLabel)
        fieldStack.addArrangedSubview(emailField)
        fieldStack.addArrangedSubview(passwordField)
        fieldStack.setCustomSpacing(30, after: myProfileLabel)
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fieldStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            fieldStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fieldStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
