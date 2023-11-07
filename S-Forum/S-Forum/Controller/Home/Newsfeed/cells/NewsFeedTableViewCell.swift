//
//  NewsFeedTableViewCell.swift
//  S-Forum
//
//  Created by Fakunabs on 20/10/2023.
//

import UIKit

class NewsFeedTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var firstHastagLabel: UILabel!
    @IBOutlet private weak var secondHastagLabel: UILabel!
    @IBOutlet private weak var thirdHastagLabel: UILabel!
    @IBOutlet private weak var blogImageView: UIImageView!
    @IBOutlet private weak var contentLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var disLikeLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 10
        firstHastagLabel.layer.cornerRadius = 8
        firstHastagLabel.layer.masksToBounds = true
        secondHastagLabel.layer.cornerRadius = 8
        secondHastagLabel.layer.masksToBounds = true
        thirdHastagLabel.layer.cornerRadius = 8
        thirdHastagLabel.layer.masksToBounds = true
    }
}

extension NewsFeedTableViewCell {
    func setUpData(newfeedBlog: NewFeedBlogs) {
        contentLabel.text = newfeedBlog.title
        blogImageView.image = newfeedBlog.image
        authorLabel.text = newfeedBlog.author
        likeLabel.text = newfeedBlog.like
        disLikeLabel.text = newfeedBlog.dislike
        commentLabel.text = newfeedBlog.comments
        firstHastagLabel.text = newfeedBlog.firstHastag
        secondHastagLabel.text = newfeedBlog.secondHastag
        thirdHastagLabel.text = newfeedBlog.thirdHastag
    }
}
