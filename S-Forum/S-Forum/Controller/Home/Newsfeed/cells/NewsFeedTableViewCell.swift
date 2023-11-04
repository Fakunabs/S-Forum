//
//  NewsFeedTableViewCell.swift
//  S-Forum
//
//  Created by Fakunabs on 20/10/2023.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var middleView: UIView!
    @IBOutlet private weak var leftView: UIView!
    @IBOutlet private weak var rightView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        middleView.layer.cornerRadius = 8
        leftView.layer.cornerRadius = 8
        rightView.layer.cornerRadius = 8
    }
}
