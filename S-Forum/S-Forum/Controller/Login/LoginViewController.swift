//
//  LoginViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 28/10/2023.
//

import UIKit

class LoginViewController: UIViewController {
    
    private var isPasswordHidden = true
    private var isBothTextFieldsNotEmpty: Bool {
        return !(emailLoginTextField.text?.isEmpty ?? true) && !(passwordLoginTextField.text?.isEmpty ?? true)
    }
    
    @IBOutlet private weak var emailLoginTextField: UITextField!
    @IBOutlet private weak var passwordLoginTextField: UITextField!
    @IBOutlet private weak var emailErrorMessageLabel: UILabel!
    @IBOutlet private weak var passwordErrorMessageLabel: UILabel!
    
    @IBOutlet private weak var loginButton: UIButton!
    @IBAction func didTapNextViewAction(_ sender: Any) {
        if validateInputTextFields() {
            guard let email = emailLoginTextField.text, let password = passwordLoginTextField.text else { return }
            let homeViewController = TabController()
            self.navigationController?.pushViewController(homeViewController, animated: true)
        }
    }
    
    
    @IBAction func didTapCreateNewAccountAction(_ sender: Any) {
        let registerViewController = RegisterViewController()
        self.navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    @IBAction func didTapForgotPasswordAction(_ sender: Any) {
        let forgotPasswordViewController = ForgotPasswordViewController()
        self.navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
    
    @IBAction func didTapShowPasswordAction(_ sender: Any) {
        isPasswordHidden.toggle()
        passwordLoginTextField.isSecureTextEntry = isPasswordHidden
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField(emailLoginTextField, isSecureTextEntry: false, placeholder: "Enter your email")
        configTextField(passwordLoginTextField, isSecureTextEntry: true, placeholder: "Enter your Password")
        setUpErrorMessageLabels(isHidden: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
    }
}

extension LoginViewController {
    private func configTextField(_ textField: UITextField, isSecureTextEntry: Bool, placeholder: String) {
        let textFields : [UITextField] = [emailLoginTextField, passwordLoginTextField]
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontGilroyMedium(size: 15)!,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColors.outerSpace.cgColor
        textField.delegate = self
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
    
    private func setUpErrorMessageLabels(isHidden: Bool) {
        emailErrorMessageLabel.isHidden = isHidden
        passwordErrorMessageLabel.isHidden = isHidden
    }
    
    private func validateInputTextFields() -> Bool {
        var isEmailValid = true
        var isPasswordValid = true
        
        if let email = emailLoginTextField.text, !AppValidation.isValidEmail(email) {
            emailLoginTextField.layer.borderColor = AppColors.red.cgColor
            emailLoginTextField.tintColor = AppColors.red
            emailErrorMessageLabel.isHidden = false
            isEmailValid = false
        }
        
        if let password = passwordLoginTextField.text {
            if !AppValidation.isValidPassword(password) {
                passwordLoginTextField.layer.borderColor = AppColors.red.cgColor
                passwordLoginTextField.tintColor = AppColors.red
                passwordErrorMessageLabel.isHidden = false
                isPasswordValid = false
                checkPasswordStrength(password: password)
            }
        }
        return isEmailValid && isPasswordValid
    }
    
    
    private func checkPasswordStrength(password: String) {
        if password.count < 6 {
            passwordErrorMessageLabel.text = "Required at least 6 characters"
        } else if !password.containsNumber {
            passwordErrorMessageLabel.text = "Required contain a number"
        } else if !password.containsSpecialCharacters {
            passwordErrorMessageLabel.text = "Required special character"
        } else if !password.containsCapitalLetters {
            passwordErrorMessageLabel.text = "Required capital letters"
        } else {
            passwordErrorMessageLabel.text = ""
        }
    }
    
    private func resetBorderColors(except textField: UITextField) {
        let textFields = [emailLoginTextField, passwordLoginTextField]
        for field in textFields where field != textField {
            field?.layer.borderColor = AppColors.outerSpace.cgColor
            field?.tintColor = AppColors.outerSpace
        }
    }
}



extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColors.doveGray.cgColor
        textField.tintColor = AppColors.doveGray
        resetBorderColors(except: textField)
        setUpErrorMessageLabels(isHidden: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColors.outerSpace.cgColor
        setUpErrorMessageLabels(isHidden: true)
    }
}
