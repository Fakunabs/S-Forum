//
//  UIImageView+Extension.swift
//  S-Forum
//
//  Created by Fakunabs on 12/11/2023.
//

import UIKit

extension UIImageView {

    func circle() {
        layer.masksToBounds = false
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func blogImageCornerRadius() {
        layer.cornerRadius = 10
    }
}
