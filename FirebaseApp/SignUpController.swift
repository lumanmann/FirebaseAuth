//
//  SignUpController.swift
//  FirebaseApp
//
//  Created by WY NG on 2/3/2019.
//  Copyright © 2019 lumanmann. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    
    let plusPhotoButton: UIButton = {
        var button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal), for: .normal) // withRenderingMode -> default is showing the image with tint color
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let emailTextField: UITextField = {
       let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        
        tf.textContentType = UITextContentType.emailAddress
        
        return tf
    }()
    
    let userTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "User"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        
        tf.textContentType = UITextContentType.emailAddress
        
        return tf
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.03)
        tf.borderStyle = .roundedRect
        tf.autocapitalizationType = UITextAutocapitalizationType.none
        
        tf.textContentType = UITextContentType.emailAddress
        
        return tf
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.layer.cornerRadius = 5.0
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        
        button.isEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(signUpClicked), for: .touchUpInside)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(plusPhotoButton)
//        NSLayoutConstraint.activate([
//            plusPhotoButton.widthAnchor.constraint(equalToConstant: 140),
//            plusPhotoButton.heightAnchor.constraint(equalToConstant: 140),
//            plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            plusPhotoButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50)
//            ])

        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, trailing: nil, bottom: nil, paddingTop: 50, paddingLeading: 0, paddingTrailing: 0, paddingBottom: 0, width: 140, height: 140)
        plusPhotoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        setupInputFields()
        
        
    }
    
    fileprivate func setupInputFields() {
        let stackView = UIStackView(arrangedSubviews: [emailTextField, userTextField, passwordTextField, signUpButton])
        
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        
        stackView.anchor(top: plusPhotoButton.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, bottom: nil, paddingTop: 40, paddingLeading: 40, paddingTrailing: 40, paddingBottom: 0, width: 0, height: 200)
        
        
    }
    
    
    @objc fileprivate func signUpClicked() {
        guard let email = emailTextField.text, let password = passwordTextField.text, email.count > 0, password.count > 0 else { return }
        
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: password) { (result, error) in
            if let error = error {
                debugPrint("Failef to create user: \(error)")
                return
            }
            
            print("Successfully created user: \(result?.user.uid ?? "")")
        }
    } 


}

