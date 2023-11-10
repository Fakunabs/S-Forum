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
    
    private var isPasswordHidden = true
    private var areAllThreeeTextFieldNotEmpty : Bool {
        return !(emailRegisterTextField.text?.isEmpty ?? true) && !(passwordRegisterTextField.text?.isEmpty ?? true) && !(confirmPasswordRegisterTextField.text?.isEmpty ?? true)
    }
    
    @IBOutlet private weak var emailRegisterTextField: UITextField!
    @IBOutlet private weak var passwordRegisterTextField: UITextField!
    @IBOutlet private weak var confirmPasswordRegisterTextField: UITextField!
    @IBOutlet private weak var registerDescriptionLabel: UILabel!
    @IBOutlet private weak var emailRegisterErrorMessageLabel: UILabel!
    @IBOutlet private weak var passwordRegisterErrorMessageLabel: UILabel!
    
    @IBOutlet private weak var confirmErrorMessageLabel: UILabel!
    
    @IBAction func didTapReturnViewAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapShowPasswordTextFieldAction(_ sender: Any) {
        isPasswordHidden.toggle()
        passwordRegisterTextField.isSecureTextEntry = isPasswordHidden
    }
    
    @IBAction func didTapShowConfirmPwTextFieldAction(_ sender: Any) {
        isPasswordHidden.toggle()
        confirmPasswordRegisterTextField.isSecureTextEntry = isPasswordHidden
    }
    
    @IBAction func didTapRegisterAction(_ sender: Any) {
        if validateInputTextFields() {
            guard let email = emailRegisterTextField.text, let password = passwordRegisterTextField.text else { return }
            Task {
                do {
                    let _ = try await Repository.regiter(email: email, password: password)
                } catch {
                    
                }
            }
        } else {
            print("b")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField(emailRegisterTextField, isSecureTextEntry: false, placeholder: "Enter your email")
        configTextField(passwordRegisterTextField, isSecureTextEntry: true, placeholder: "Enter your password")
        configTextField(confirmPasswordRegisterTextField, isSecureTextEntry: true, placeholder: "Confirm password")
        configRegisterDescriptionText()
        setUpErrorMessageLabels(isHidden: true)
    }
}

extension RegisterViewController {
    private func configTextField(_ textField: UITextField, isSecureTextEntry: Bool, placeholder: String) {
        let textFields : [UITextField] = [emailRegisterTextField, passwordRegisterTextField, confirmPasswordRegisterTextField]
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontGilroyMedium(size: 15)!,
            .foregroundColor: AppColors.doveGray,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.isSecureTextEntry = isSecureTextEntry
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColors.outerSpace.cgColor
        textField.delegate = self
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
    
    private func setUpErrorMessageLabels(isHidden: Bool) {
        emailRegisterErrorMessageLabel.isHidden = isHidden
        passwordRegisterErrorMessageLabel.isHidden = isHidden
        confirmErrorMessageLabel.isHidden = isHidden
    }
    
    private func validateInputTextFields() -> Bool {
        var isEmailValid = true
        var isPasswordValid = true
        var isConfirmPasswordValid = true
        
        if let email = emailRegisterTextField.text, !AppValidation.isValidEmail(email) {
            emailRegisterTextField.layer.borderColor = AppColors.red.cgColor
            emailRegisterErrorMessageLabel.text = "Invalid email address"
            emailRegisterErrorMessageLabel.isHidden = false
            isEmailValid = false
        }
        
        var password: String?
        if let pwd = passwordRegisterTextField.text {
            password = pwd
            if !AppValidation.isValidPassword(pwd) {
                passwordRegisterTextField.layer.borderColor = AppColors.red.cgColor
                passwordRegisterErrorMessageLabel.text = "Password does not meet requirements"
                passwordRegisterErrorMessageLabel.isHidden = false
                isPasswordValid = false
                checkPasswordStrength(password: pwd)
            }
        }
        
        if let confirmPassword = confirmPasswordRegisterTextField.text {
            if confirmPassword.isEmpty {
                confirmPasswordRegisterTextField.layer.borderColor = AppColors.red.cgColor
                confirmErrorMessageLabel.text = "Confirm password cannot be empty"
                confirmErrorMessageLabel.isHidden = false
                isConfirmPasswordValid = false
            } else if confirmPassword != password {
                confirmPasswordRegisterTextField.layer.borderColor = AppColors.red.cgColor
                confirmErrorMessageLabel.text = "Passwords do not match"
                confirmErrorMessageLabel.isHidden = false
                isConfirmPasswordValid = false
            }
        }
        
        if isPasswordValid, let confirmPassword = confirmPasswordRegisterTextField.text, confirmPassword != passwordRegisterTextField.text {
            confirmPasswordRegisterTextField.layer.borderColor = AppColors.red.cgColor
            confirmErrorMessageLabel.text = "Passwords do not match"
            confirmErrorMessageLabel.isHidden = false
            isConfirmPasswordValid = false
        }
        return isEmailValid && isPasswordValid && isConfirmPasswordValid
    }
    
    private func checkPasswordStrength(password: String) {
        if password.count < 6 {
            passwordRegisterErrorMessageLabel.text = "Required at least 6 characters"
        } else if !password.containsNumber {
            passwordRegisterErrorMessageLabel.text = "Required contain a number"
        } else {
            passwordRegisterErrorMessageLabel.text = ""
        }
    }
    
    private func resetBorderColors(except textField: UITextField) {
        let textFields = [emailRegisterTextField, passwordRegisterTextField, confirmPasswordRegisterTextField]
        for field in textFields where field != textField {
            field?.layer.borderColor = AppColors.outerSpace.cgColor
            field?.tintColor = AppColors.outerSpace
        }
    }
}

extension RegisterViewController: UITextFieldDelegate {
    
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
