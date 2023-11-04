//
//  UserViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 30/10/2023.
//

import UIKit
import DropDown

class UserViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    private let userDropDown = DropDown()
    private let actionList = ["Logout"]
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var avatarUserImageView: UIImageView!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var dropDownView: UIView!
    @IBOutlet private weak var userScrollView: UIScrollView!
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCornerRadius()
        configDropDown()
        reloadScrollView()
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
    
    private func reloadScrollView() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        userScrollView.addSubview(refreshControl)
    }
    
    @objc private func refreshData() {
        refreshControl.endRefreshing()
    }
}
