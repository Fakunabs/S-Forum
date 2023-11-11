//
//  SpinnerLoadingView.swift
//  S-Forum
//
//  Created by Fakunabs on 11/11/2023.
//

import UIKit

class SpinnerLoadingView: UIView {
    
    let spinningCircle = CAShapeLayer()
    let gradientLayer = CAGradientLayer()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
    private func configure() {
        frame = CGRect(x: 0, y: 0, width: 66, height: 66)
        let rect = self.bounds
        let circularPath = UIBezierPath(ovalIn: rect)
        
        spinningCircle.path = circularPath.cgPath
        spinningCircle.fillColor = UIColor.clear.cgColor
        spinningCircle.strokeColor = AppColors.vermilion.cgColor
        spinningCircle.lineWidth = 6
        spinningCircle.strokeEnd = 0.75
        spinningCircle.lineCap = .round
        self.layer.addSublayer(spinningCircle)
    }
    
    func animate() {
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(rotationAngle : .pi)
        }) { (completion) in
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear, animations: {
                self.transform = CGAffineTransform(rotationAngle : 0)
            }) { (completion) in
                self.animate()
            }
        }
    }
}
