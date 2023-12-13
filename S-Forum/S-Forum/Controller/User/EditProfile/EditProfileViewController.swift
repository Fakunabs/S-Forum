//
//  EditProfileViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 13/11/2023.
//

import UIKit

protocol EditProfileViewControllerDelegate: AnyObject {
    func didTapSaveReloadDataInUserProfile()
}
class EditProfileViewController: UIViewController {

    private var selectedGender: Gender?
    weak var delegate: EditProfileViewControllerDelegate?
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    @IBOutlet private weak var maleRadioButton: UIButton!
    @IBOutlet private weak var femaleRadioButton: UIButton!
    @IBOutlet private weak var firstNameTextField: UITextField!
    @IBOutlet private weak var lastNameTextField: UITextField!
    @IBOutlet private weak var dayOfBirthTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var errorMessageLabel: UILabel!
    
    @IBAction func didTapDismissAction(_ sender: Any) {

    }
    
    
    @IBAction func didTapXcloseAction(_ sender: Any) {
        dismissLoginView()
    }
    
    
    @IBAction func didTapCancelAction(_ sender: Any) {
        dismissLoginView()
    }
    
    
    @IBAction func didTapSaveAction(_ sender: Any) {
        if areAllTextFieldsValid() {
            let firstName = firstNameTextField.text ?? ""
            let lastName = lastNameTextField.text ?? ""
            let dayOfBirth = convertDateString(dayOfBirthTextField.text ?? "", fromFormat: "dd/MM/yyyy", toFormat: "yyyy-MM-dd") ?? "Invalid date format"
            let genderID = selectedGender?.rawValue ?? false
            let phone =  Int(phoneNumberTextField.text ?? "") ?? 0
            Task {
                do {
                    _ = try await Repository.updateInformation(firstName: firstName, lastName: lastName, gender: genderID, dayOfBirth: dayOfBirth, phone: phone)
                    var currentUser = AuthenticationManager.shared.getUser()
                    currentUser?.firstName = firstName
                    currentUser?.lastName = lastName
                    currentUser?.dayOfBirth = dayOfBirth
                    currentUser?.gender = genderID
                    currentUser?.phone = phone
                    AuthenticationManager.shared.cache(user: currentUser)
                } catch {
                    print(error.localizedDescription)
                }
            }
            errorMessageLabel.isHidden = false
            errorMessageLabel.textColor = AppColors.shamRock
            errorMessageLabel.text = "Edit Successfully"
            delegate?.didTapSaveReloadDataInUserProfile()
        } else {
            print("Thiếu thông tin, nhập lại")
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCornerRadius()
        setUpTargetForGenderRadioButton()
        getUserData()
        dateTimePicker()
        setUpErrorMessageLabels(isHidden: true)
        configTextField(firstNameTextField)
        configTextField(lastNameTextField)
        configTextField(dayOfBirthTextField)
        configTextField(phoneNumberTextField)
    }
    
    private func configCornerRadius() {
        containerView.layer.cornerRadius = 10
        saveButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
    }
    
    private func configTextField(_ textField: UITextField) {
        let textFields : [UITextField] = [firstNameTextField, lastNameTextField, dayOfBirthTextField, phoneNumberTextField]
        textFields.forEach { textField in
            textField.delegate = self
            textField.layer.borderWidth = 1
            textField.layer.cornerRadius = 5
            
        }
    }
    
    private func setUpErrorMessageLabels(isHidden: Bool) {
        errorMessageLabel.isHidden = isHidden
        errorMessageLabel.textColor = AppColors.red
        errorMessageLabel.text = "Infomation must not be empty"
    }
    
    private func setUpTargetForGenderRadioButton() {
        let radioButtons: [UIButton] = [maleRadioButton, femaleRadioButton]
        radioButtons.forEach { radioButton in
            radioButton.addTarget(self, action: #selector(genderRadioButtonTapped(_:)), for: .touchUpInside)
        }
    }
    
    private func convertDateTimeFromMongoDBToSwift(_ dayOfBirth: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = dateFormatter.date(from: dayOfBirth) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    private func dateTimePicker() {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 250)
        dayOfBirthTextField.inputView = datePicker
    }
    
    private func resetBorderColors(except textField: UITextField) {
        let textFields = [firstNameTextField, lastNameTextField, dayOfBirthTextField, phoneNumberTextField]
        for field in textFields where field != textField {
            field?.layer.borderColor = AppColors.outerSpace.cgColor
            field?.tintColor = AppColors.outerSpace
        }
    }
    
    private func areAllTextFieldsValid() -> Bool {
        var isFirstNameValid = true
        var isLastNameValid = true
        var isBirthDayValid = true
        var isPhoneNumberValid = true
        var isGenderValid = true

        if let firstName = firstNameTextField.text, firstName.isEmpty == true {
            errorMessageLabel.isHidden = false
            firstNameTextField.layer.borderColor = AppColors.red.cgColor
            isFirstNameValid = false
        }
        
        if let lastName = lastNameTextField.text, lastName.isEmpty == true {
            errorMessageLabel.isHidden = false
            lastNameTextField.layer.borderColor = AppColors.red.cgColor
            isLastNameValid = false
        }

        if let dayOfBirth = dayOfBirthTextField.text, dayOfBirth.isEmpty == true {
            errorMessageLabel.isHidden = false
            dayOfBirthTextField.layer.borderColor = AppColors.red.cgColor
            isBirthDayValid = false
        }

        if let phoneNumber = phoneNumberTextField.text, phoneNumber.isEmpty == true {
            errorMessageLabel.isHidden = false
            phoneNumberTextField.layer.borderColor = AppColors.red.cgColor
            isPhoneNumberValid = false
        }

        if selectedGender == nil {
            errorMessageLabel.isHidden = false
            isGenderValid = false
        }

        return isFirstNameValid && isLastNameValid && isBirthDayValid && isPhoneNumberValid && isGenderValid
    }
    
    func convertDateString(_ dateString: String, fromFormat: String, toFormat: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = toFormat
            return dateFormatter.string(from: date)
        }
        
        return nil
    }

}


extension EditProfileViewController {
    
    @objc private func genderRadioButtonTapped(_ sender: UIButton) {
        let radioButtons: [UIButton: Gender] = [
            maleRadioButton: .male,
            femaleRadioButton: .female,
        ]
        for (button, gender) in radioButtons {
            if button == sender {
                selectedGender = gender
                button.setImage(AppImages.selectedRadioButton, for: .normal)
            } else {
                button.setImage(AppImages.defaultRadioButton, for: .normal)
                
            }
        }
    }
    
    @objc private func dismissLoginView() {
        self.dismiss(animated: false)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker)
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dayOfBirthTextField.text = formatter.string(from: sender.date)
        
    }
    
}

extension EditProfileViewController {
    private func getUserData() {
        Task {
            guard let editUser = try await Repository.getUserInfomation() else { return }
            firstNameTextField.text = editUser.firstName ?? ""
            lastNameTextField.text = editUser.lastName ?? ""
            phoneNumberTextField.text = String(editUser.phone ?? 0)
            dayOfBirthTextField.text = convertDateTimeFromMongoDBToSwift(editUser.dayOfBirth ?? "--")
            if let gender = editUser.getGender() {
                switch gender {
                case .male:
                    selectedGender = .male
                    maleRadioButton.setImage(AppImages.selectedRadioButton, for: .normal)
                case .female:
                    selectedGender = .female
                    femaleRadioButton.setImage(AppImages.selectedRadioButton, for: .normal)
                }
            }
        }
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    
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

