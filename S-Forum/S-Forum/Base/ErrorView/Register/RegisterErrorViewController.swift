//
//  RegisterErrorViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 12/11/2023.
//

import UIKit

class RegisterErrorViewController: UIViewController {

    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var dismissButton: UIButton!
    
    @IBAction func didTapCloseButtonAction(_ sender: Any) {
        createFeedbackButton()
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
    
    private func createFeedbackButton() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let generator2 = UIImpactFeedbackGenerator(style: .soft)
        generator2.impactOccurred()
    }
}

extension RegisterErrorViewController {
    @objc private func dismissLoginView() {
        self.dismiss(animated: false)
    }
}
