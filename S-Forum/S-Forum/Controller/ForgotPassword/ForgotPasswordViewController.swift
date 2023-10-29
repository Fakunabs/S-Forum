//
//  ForgotPasswordViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 29/10/2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    struct Constant {
        static let resetPassword = "* We will send you a message to set or reset your new password"
    }
    
    @IBOutlet private weak var emailForgotPasswordTextField: UITextField!
    
    @IBOutlet private weak var resetPasswordLabel: UILabel!
    
    @IBAction func didTapReturnViewAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField(placeholder: "Enter your email address")
        configResetPasswordText()
    }
}

extension ForgotPasswordViewController {
    private func configTextField(placeholder: String) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: AppFonts.fontGilroyMedium(size: 15)!]
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: emailForgotPasswordTextField.frame.height))
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        emailForgotPasswordTextField.attributedPlaceholder = attributedPlaceholder
        emailForgotPasswordTextField.leftView = leftView
        emailForgotPasswordTextField.leftViewMode = .always
        emailForgotPasswordTextField.layer.cornerRadius = 10
    }
    
    private func configResetPasswordText() {
        let resetPassword = Constant.resetPassword
        let attributedString = NSMutableAttributedString(string: resetPassword)
        let range = (attributedString.string as NSString).range(of: "*")
        attributedString.addAttributes([.foregroundColor: AppColors.redOrange], range: range)
        resetPasswordLabel.attributedText = attributedString
    }
}
