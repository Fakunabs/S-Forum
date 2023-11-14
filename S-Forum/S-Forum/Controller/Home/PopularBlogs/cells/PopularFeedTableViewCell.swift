//
//  PopularFeedTableViewCell.swift
//  S-Forum
//
//  Created by Fakunabs on 13/11/2023.
//

import UIKit

class PopularFeedTableViewCell: UITableViewCell {
    
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var blogImageView: UIImageView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var numberOfLikeLabel: UILabel!
    @IBOutlet private weak var numberOfDislikeLabel: UILabel!
    @IBOutlet private weak var createdDayLabel: UILabel!
    @IBOutlet private weak var avatarBlogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configRadius()
    }
    
    private func configRadius() {
        containerView.layer.cornerRadius = 10
        avatarBlogImageView.circle()
    }
    
}
