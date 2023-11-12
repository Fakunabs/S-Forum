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
    func setUpData(newfeedBlog: NewFeedBlogs, searchText: String?) {
        // Làm bôi đen chữ được tìm kiếm trong title
        if let searchText = searchText, !searchText.isEmpty {
            let titleAttributedString = highlightTextInString(newfeedBlog.title, searchText: searchText)
            contentLabel.attributedText = titleAttributedString
        } else {
            contentLabel.text = newfeedBlog.title
        }
        
        // Làm bôi đen chữ được tìm kiếm trong author
        if let searchText = searchText, !searchText.isEmpty {
            let authorAttributedString = highlightTextInString(newfeedBlog.author, searchText: searchText)
            authorLabel.attributedText = authorAttributedString
        } else {
            authorLabel.text = newfeedBlog.author
        }
        blogImageView.image = newfeedBlog.image
        likeLabel.text = newfeedBlog.like
        disLikeLabel.text = newfeedBlog.dislike
        commentLabel.text = newfeedBlog.comments
        firstHastagLabel.text = newfeedBlog.firstHastag
        secondHastagLabel.text = newfeedBlog.secondHastag
        thirdHastagLabel.text = newfeedBlog.thirdHastag
    }
    
    private func highlightTextInString(_ text: String, searchText: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        var searchRange = NSRange(location: 0, length: text.count)
        
        while searchRange.location != NSNotFound {
            let range = (text as NSString).range(of: searchText, options: .caseInsensitive, range: searchRange)
            if range.location != NSNotFound {
                attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: AppColors.boulder, range: range)
                searchRange.location = range.upperBound
                searchRange.length = text.count - searchRange.location
            } else {
                searchRange.location = NSNotFound
            }
        }
        return attributedString
    }
    
    func setUpDataForTemp(newfeedBlog: NewFeedBlogs) {
        contentLabel.text = newfeedBlog.title
        authorLabel.text = newfeedBlog.author
        blogImageView.image = newfeedBlog.image
        likeLabel.text = newfeedBlog.like
        disLikeLabel.text = newfeedBlog.dislike
        commentLabel.text = newfeedBlog.comments
        firstHastagLabel.text = newfeedBlog.firstHastag
        secondHastagLabel.text = newfeedBlog.secondHastag
        thirdHastagLabel.text = newfeedBlog.thirdHastag
    }
}

