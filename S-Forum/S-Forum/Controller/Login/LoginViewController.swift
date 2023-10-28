//
//  LoginViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 28/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var loginTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField()
    }
}

extension LoginViewController {
    
    private func configTextField() {
        loginTextField.layer.cornerRadius = 10
        passwordTextField.layer.cornerRadius = 10
    }
}
