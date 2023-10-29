//
//  LoginViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 28/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet private weak var usernameLoginTextField: UITextField!
    @IBOutlet private weak var passwordLoginTextField: UITextField!
    
    @IBAction func didTapNextViewAction(_ sender: Any) {
        let homeViewController = TabController()
        self.navigationController?.pushViewController(homeViewController, animated: true)
    }
    
    
    @IBAction func didTapCreateNewAccountAction(_ sender: Any) {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @IBAction func didTapForgotPasswordAction(_ sender: Any) {
        let forgotPasswordViewController = ForgotPasswordViewController()
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField(usernameLoginTextField, isSecureTextEntry: false, placeholder: "Username or Email")
        configTextField(passwordLoginTextField, isSecureTextEntry: true, placeholder: "Password")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
    }
}

extension LoginViewController {
    private func configTextField(_ textField: UITextField, isSecureTextEntry: Bool, placeholder: String) {
        let textFields : [UITextField] = [usernameLoginTextField, passwordLoginTextField]
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontGilroyMedium(size: 15)!,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.isSecureTextEntry = isSecureTextEntry
        textFields.forEach { textField in
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: textField.frame.height))
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.layer.cornerRadius = 10
        }
        if textField == passwordLoginTextField {
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: textField.frame.height))
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
    }
}
