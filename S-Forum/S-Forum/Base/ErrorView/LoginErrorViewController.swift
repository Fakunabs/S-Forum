//
//  LoginErrorViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 09/11/2023.
//

import UIKit
import iProgressHUD

class LoginErrorViewController: UIViewController {
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    
    @IBAction private func didTapCloseButtonAction(_ sender: Any) {
        dismissLoginView()
        createFeedbackButton()
    }
    @IBAction private func didTapCloseErrorViewAction(_ sender: Any) {
        dismissLoginView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func configView() {
        self.view.backgroundColor = .clear
        containerView.layer.cornerRadius = 20
        dismissButton.layer.cornerRadius = 20
    }
    
    private func createFeedbackButton() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let generator2 = UIImpactFeedbackGenerator(style: .soft)
        generator2.impactOccurred()
    }
}

extension LoginErrorViewController {
    @objc private func dismissLoginView() {
        self.dismiss(animated: false)
    }
}
