//
//  LoginErrorViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 09/11/2023.
//

import UIKit

class LoginErrorViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    
    @IBAction func didTapCloseButtonAction(_ sender: Any) {
        dismissLoginView()
    }
    @IBAction func didTapCloseErrorViewAction(_ sender: Any) {
        dismissLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        containerView.layer.cornerRadius = 20
        dismissButton.layer.cornerRadius = 20
    }
}

extension LoginErrorViewController {
    @objc private func dismissLoginView() {
        self.dismiss(animated: false)
    }
}
