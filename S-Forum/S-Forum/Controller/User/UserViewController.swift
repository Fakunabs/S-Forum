//
//  UserViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 30/10/2023.
//

import UIKit

class UserViewController: UIViewController {
    
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var avatarUserImageView: UIImageView!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBAction func didTapReturnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCornerRadius()
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
}
