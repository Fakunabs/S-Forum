//
//  ForgotPasswordViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 29/10/2023.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    struct Constant {
        static let resetPassword = "* We will send you a message to set or reset your new password"
    }
    
    @IBOutlet private weak var emailForgotPasswordTextField: UITextField!
    @IBOutlet private weak var resetPasswordLabel: UILabel!
    @IBOutlet private weak var arrowRightImage: UIImageView!
    @IBOutlet private weak var loadingButtonActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private weak var emailForgotErrorMessageLabel: UILabel!
    
    @IBAction func didTapReturnViewAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func didTapForgotPasswordAction(_ sender: Any) {
        setUpLoadView(isHidden: false)
        loadingButtonActivityIndicatorView.startAnimating()
        if validateInputTextFields() {
            guard let email = emailForgotPasswordTextField.text else { return }
            Task {
                do {
                    let _ = try await Repository.forgotPassword(email: email)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {}
                    let forgotSuccessView = ForgotPasswordSuccessViewController()
                    forgotSuccessView.modalPresentationStyle = .overFullScreen
                    forgotSuccessView.modalTransitionStyle = .coverVertical
                    setUpLoadView(isHidden: true)
                    loadingButtonActivityIndicatorView.stopAnimating()
                    self.present(forgotSuccessView, animated: false, completion: nil)
                } catch {
                    DispatchQueue.main.async {
                        self.setUpLoadView(isHidden: true)
                        self.loadingButtonActivityIndicatorView.stopAnimating()
                    }
                    print(error.localizedDescription)
                }
            }
        } else {
            setUpLoadView(isHidden: true)
            loadingButtonActivityIndicatorView.stopAnimating()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configTextField(placeholder: "Enter your email address")
        configResetPasswordText()
        setUpErrorMessageLabels(isHidden: true)
        setUpLoadView(isHidden: true)
    }
}

extension ForgotPasswordViewController {
    private func configTextField(placeholder: String) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontGilroyMedium(size: 15)!,
            .foregroundColor: AppColors.doveGray,
        ]
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 53, height: emailForgotPasswordTextField.frame.height))
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        emailForgotPasswordTextField.attributedPlaceholder = attributedPlaceholder
        emailForgotPasswordTextField.layer.borderWidth = 1
        emailForgotPasswordTextField.layer.borderColor = AppColors.outerSpace.cgColor
        emailForgotPasswordTextField.leftView = leftView
        emailForgotPasswordTextField.leftViewMode = .always
        emailForgotPasswordTextField.layer.cornerRadius = 10
        emailForgotPasswordTextField.delegate = self
    }
    
    private func configResetPasswordText() {
        let resetPassword = Constant.resetPassword
        let attributedString = NSMutableAttributedString(string: resetPassword)
        let range = (attributedString.string as NSString).range(of: "*")
        attributedString.addAttributes([.foregroundColor: AppColors.redOrange], range: range)
        resetPasswordLabel.attributedText = attributedString
    }
    
    private func validateInputTextFields() -> Bool {
        var isEmailValid = true
        if let email = emailForgotPasswordTextField.text, !AppValidation.isValidEmail(email) {
            emailForgotPasswordTextField.layer.borderColor = AppColors.red.cgColor
            emailForgotPasswordTextField.tintColor = AppColors.red
            emailForgotErrorMessageLabel.isHidden = false
            isEmailValid = false
        }
        return isEmailValid
    }
    
    private func setUpLoadView(isHidden: Bool) {
        arrowRightImage.isHidden = !isHidden
        loadingButtonActivityIndicatorView.isHidden = isHidden
    }
    
    private func setUpErrorMessageLabels(isHidden: Bool) {
        emailForgotErrorMessageLabel.isHidden = isHidden
    }
    
}

extension ForgotPasswordViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColors.doveGray.cgColor
        textField.tintColor = AppColors.doveGray
        setUpErrorMessageLabels(isHidden: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColors.outerSpace.cgColor
        setUpErrorMessageLabels(isHidden: true)
    }
    
}
