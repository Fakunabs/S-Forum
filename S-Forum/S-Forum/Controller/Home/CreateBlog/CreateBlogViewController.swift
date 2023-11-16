//
//  CreateBlogViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 14/11/2023.
//

import UIKit

class CreateBlogViewController: UIViewController {
    
    var hastagData = ["","General Discussion", "News and Updates", "Technology", "Sports", "Entertainment", "Food and Cooking", "Travel", "Music", "Gaming", "Health and Fitness", "Art and Creativity", "Science and Nature", "Books and Literature", "Home and Garden", "Business and Finance"]
    
    private let pickerView = UIPickerView()
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var publishedButton: UIButton!
    @IBOutlet private weak var titleTextFIeld: UITextField!
    @IBOutlet private weak var hastagTextField: UITextField!
    @IBOutlet private weak var contentTextField: UITextField!
    @IBOutlet private weak var contentErrorMessageLabel: UILabel!
    
    @IBAction func didTapCloseAction(_ sender: Any) {
        dismissLoginView()
    }
    
    
    
    @IBAction func didTapPublishPostAction(_ sender: Any) {
        if areAllTextFieldsValid() {
            let title = titleTextFIeld.text ?? ""
            let content = contentTextField.text ?? ""
            Task {
                do {
                    let _ = try await Repository.createPost(title: title, content: content)
                } catch {
                    print(error.localizedDescription)
                }
            }
            contentErrorMessageLabel.isHidden = false
            contentErrorMessageLabel.textColor = AppColors.shamRock
            contentErrorMessageLabel.text = "Post Successfully"
        } else {
            print("Not valid Text field")
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        hastagTextField.inputView = pickerView
        configConerRadiusComponent()
        configTextField(titleTextFIeld, placeholder: "Title")
        configTextField(hastagTextField, placeholder: "Please selected category")
        configTextField(contentTextField, placeholder: "Insert text here...")
        setUpErrorMessageLabels(isHidden: true)
    }
    
    private func configConerRadiusComponent() {
        containerView.layer.cornerRadius = 10
        publishedButton.layer.cornerRadius = 5
    }
}

extension CreateBlogViewController {
    private func configTextField(_ textField: UITextField, placeholder: String) {
        let textFields : [UITextField] = [titleTextFIeld, hastagTextField, contentTextField]
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppColors.lightGrey,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.layer.borderWidth = 1
        textField.layer.borderColor = AppColors.lightGrey.cgColor
        textFields.forEach { textField in
            textField.delegate = self
            textField.layer.cornerRadius = 4
        }
    }
    
    private func areAllTextFieldsValid() -> Bool {
        var isTitleValid = true
        var isContentValid = true
        // TODO : Error
        if let title = titleTextFIeld.text, title.isEmpty == true {
            contentErrorMessageLabel.isHidden = false
            titleTextFIeld.layer.borderColor = AppColors.red.cgColor
            isTitleValid = false
        }
        
        if let content = contentTextField.text, content.isEmpty == true {
            contentErrorMessageLabel.isHidden = false
            contentTextField.layer.borderColor = AppColors.red.cgColor
            isContentValid = false
        }
        return isTitleValid && isContentValid
    }
    
    private func setUpErrorMessageLabels(isHidden: Bool) {
        contentErrorMessageLabel.isHidden = isHidden
    }
    
    private func resetBorderColors(except textField: UITextField) {
        let textFields = [titleTextFIeld, hastagTextField, contentTextField]
        for field in textFields where field != textField {
            field?.layer.borderColor = AppColors.lightGrey.cgColor
            field?.tintColor = AppColors.lightGrey
        }
    }
}

extension CreateBlogViewController {
    @objc private func dismissLoginView() {
        self.dismiss(animated: false)
    }
}

extension CreateBlogViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return hastagData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return hastagData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        hastagTextField.text = hastagData[row]
    }
}

extension CreateBlogViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColors.doveGray.cgColor
        textField.tintColor = AppColors.doveGray
        resetBorderColors(except: textField)
        setUpErrorMessageLabels(isHidden: true)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = AppColors.lightGrey.cgColor
        setUpErrorMessageLabels(isHidden: true)
    }
}
