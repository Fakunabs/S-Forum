//
//  RegisterViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 28/10/2023.
//

import UIKit

class RegisterViewController: UIViewController {

    struct Constant {
        static let registerDescriptionText = "By clicking the Register button, you agree to the public offer"
    }
    
    @IBOutlet private weak var usernameRegisterTextField: UITextField!
    @IBOutlet private weak var passwordRegisterTextField: UITextField!
    @IBOutlet private weak var confirmPasswordRegisterTextField: UITextField!
    @IBOutlet private weak var registerDescriptionLabel: UILabel!
    
    @IBAction func didTapReturnViewAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField(usernameRegisterTextField, isSecureTextEntry: false, placeholder: "Username or Email")
        configTextField(passwordRegisterTextField, isSecureTextEntry: true, placeholder: "Password")
        configTextField(confirmPasswordRegisterTextField, isSecureTextEntry: true, placeholder: "Confirm Password")
        configRegisterDescriptionText()
    }
}

extension RegisterViewController {
    private func configTextField(_ textField: UITextField, isSecureTextEntry: Bool, placeholder: String) {
        let textFields : [UITextField] = [usernameRegisterTextField, passwordRegisterTextField, confirmPasswordRegisterTextField]
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
        if textField ==  passwordRegisterTextField || textField == confirmPasswordRegisterTextField  {
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: textField.frame.height))
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
    }
}

extension RegisterViewController {
    private func configRegisterDescriptionText() {
        let registerDescriptionText = Constant.registerDescriptionText
        let attributedString = NSMutableAttributedString(string: registerDescriptionText)
        let range = (attributedString.string as NSString).range(of: "Register")
        attributedString.addAttributes([.foregroundColor: AppColors.redOrange], range: range)
        registerDescriptionLabel.attributedText = attributedString
    }
}
