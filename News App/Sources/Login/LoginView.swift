//
//  LoginView.swift
//  News App
//
//  Created by Islomiddin on 23/08/22.
//

import UIKit

class LoginView: UIView {
    
    let fieldStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    let loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "Email"
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
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: field.frame.height))
        field.leftViewMode = .always
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.layer.borderWidth = 1
        field.layer.cornerRadius = 20
        return field
    }()
    
    let buttonsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGreen
        button.tintColor = .white
        button.setTitle("Continue", for: .normal)
        button.contentHorizontalAlignment = .center
        button.layer.cornerRadius = 20
        return button
    }()
    
    let registrationButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Go to Registration?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 10)
        button.contentHorizontalAlignment = .center
        button.tintColor = .black
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
    }
    
    private func configureUI() {
        
        addSubview(fieldStack)
        addSubview(buttonsStack)
        
        fieldStack.addArrangedSubview(loginLabel)
        fieldStack.addArrangedSubview(emailField)
        fieldStack.addArrangedSubview(passwordField)
        fieldStack.setCustomSpacing(40, after: loginLabel)
        fieldStack.translatesAutoresizingMaskIntoConstraints = false
        
        buttonsStack.addArrangedSubview(continueButton)
        buttonsStack.addArrangedSubview(registrationButton)
        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            fieldStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            fieldStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            fieldStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            buttonsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            buttonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            buttonsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            emailField.heightAnchor.constraint(equalToConstant: 40),
            passwordField.heightAnchor.constraint(equalToConstant: 40),
            continueButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

}
