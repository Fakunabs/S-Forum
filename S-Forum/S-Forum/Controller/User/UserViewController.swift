//
//  UserViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 30/10/2023.
//

import UIKit
import DropDown
import SDWebImage

class UserViewController: BaseViewController {
    
    
    private let refreshControl = UIRefreshControl()
    private let userDropDown = DropDown()
    private let actionList = ["Logout"]
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var avatarUserImageView: UIImageView!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var dropDownView: UIView!
    @IBOutlet private weak var userScrollView: UIScrollView!
    @IBOutlet private weak var avatarNavbarImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userGenderLabel: UILabel!
    @IBOutlet private weak var userDateOfBirthLabel: UILabel!
    @IBOutlet private weak var userPhoneLabel: UILabel!
    
    @IBAction private func didTapReturnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func didTapedDropDownAction(_ sender: Any) {
        userDropDown.show()
        userDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.tabBarController?.dismiss(animated: false, completion: nil)
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    
    @IBAction func didTapEditProfileAction(_ sender: Any) {
        let editProfile = EditProfileViewController()
        editProfile.modalPresentationStyle = .overFullScreen
        editProfile.modalTransitionStyle = .coverVertical
        editProfile.delegate = self
        self.present(editProfile, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCornerRadius()
        configDropDown()
        reloadScrollView()
        configCornerRadiusImage()
        getUserInfomation()
    }
}

extension UserViewController {
    private func configCornerRadius() {
        coverImageView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
        editProfileButton.layer.cornerRadius = 5
        avatarUserImageView.layer.cornerRadius = avatarUserImageView.frame.size.width / 2
        avatarUserImageView.clipsToBounds = true
    }
    
    
    
    private func configDropDown() {
        userDropDown.cornerRadius = 10
        userDropDown.anchorView = dropDownView
        userDropDown.dataSource = actionList
        userDropDown.bottomOffset = CGPoint(x: 0, y: (userDropDown.anchorView?.plainView.bounds.height)!)
        userDropDown.topOffset = CGPoint(x: 0, y: -(userDropDown.anchorView?.plainView.bounds.height)!)
        userDropDown.direction = .bottom
        userDropDown.textColor = AppColors.vermilion
        userDropDown.textFont = AppFonts.fontGilroyMedium(size: 15)!
    }
    
    private func configCornerRadiusImage() {
        avatarUserImageView.circle()
        avatarNavbarImageView.circle()
    }
    
    private func reloadScrollView() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        userScrollView.addSubview(refreshControl)
        
    }
    
    @objc private func refreshData() {
        getUserInfomation()
        refreshControl.endRefreshing()
    }
}

extension UserViewController {
    private func getUserInfomation() {
        Task {
            guard let user = try await Repository.getUserInfomation() else { return }
            avatarUserImageView.sd_setImage(with: URL(string: user.profileImage ?? ""), placeholderImage: UIImage(named: "user-default-avatar"), options: .continueInBackground, completed: nil)
            avatarNavbarImageView.sd_setImage(with: URL(string: user.profileImage ?? ""), placeholderImage: UIImage(named: "user-default-avatar"), options: .continueInBackground, completed: nil)
            let firstName = user.firstName ?? ""
            let lastName = user.lastName ?? ""
            userNameLabel.text = lastName + " " + firstName
            
            
            if let gender = user.gender {
                userGenderLabel.text = gender ? "MALE" : "FEMALE"
            } else {
                userGenderLabel.text = "unavailable"
            }
            // Date of Birth
            if let dayOfBirth = user.dayOfBirth {
                userDateOfBirthLabel.text = convertDateTimeFromMongoDBToSwift(dayOfBirth)
            } else {
                userDateOfBirthLabel.text = "unavailable"
            }
            // Phone number
            if let phone = user.phone {
                userPhoneLabel.text = String(phone)
            } else {
                userPhoneLabel.text = ""
            }
        }
    }
    
    func getBlogOwnerUserInfomation() {
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
}

extension UserViewController: EditProfileViewControllerDelegate {
    func didTapSaveReloadDataInUserProfile() {
        getUserInfomation()
    }
}
