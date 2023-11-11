//
//  LostConnectionViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 10/11/2023.
//

import UIKit

class LostConnectionViewController: UIViewController {
    
    private let spinningCircleView = SpinnerLoadingView()

    @IBOutlet private weak var loadingView: UIView!
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
        configureSpinningCircleView()
        spinningCircleView.animate()
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
    
    private func configureSpinningCircleView() {
        loadingView.addSubview(spinningCircleView)
    }

}

extension LostConnectionViewController {
    @objc private func dismissLoginView() {
        self.dismiss(animated: false)
    }
}
