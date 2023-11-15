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
        blogImageView.blogImageCornerRadius()
    }
}

extension PopularFeedTableViewCell {
    func setUpDataPopularBlog(newfeedBlog: PopularBlog, searchText: String?) {
        if let searchText = searchText, !searchText.isEmpty {
            let titleAttributedString = highlightTextInString(newfeedBlog.title ?? "Error Content", searchText: searchText)
            contentLabel.attributedText = titleAttributedString
        } else {
            contentLabel.text = newfeedBlog.title
        }
        if let blogImages = newfeedBlog.blogImage, !blogImages.isEmpty {
            if let firstImageURL = URL(string: blogImages[0]) {
                blogImageView.sd_setImage(with: firstImageURL, placeholderImage: AppImages.blogImageSgroupLogoIcon, options: .continueInBackground, completed: nil)
            } else {
                blogImageView.image = AppImages.blogImageSgroupLogoIcon
            }
        } else {
            blogImageView.image = AppImages.blogImageSgroupLogoIcon
        }
        authorLabel.text = (newfeedBlog.userID?.firstName ?? "Error") + " " + (newfeedBlog.userID?.lastName ?? "")
        avatarBlogImageView.sd_setImage(with: URL(string: newfeedBlog.userID?.profileImage ?? ""), placeholderImage: UIImage(named: "user-default-avatar"), options: .continueInBackground, completed: nil)
        createdDayLabel.text = convertDateTimeFromMongoDBToSwift(newfeedBlog.createdAt ?? "Error Day")
        numberOfLikeLabel.text = "\(countReactions(reactions: newfeedBlog.reaction, reactionType: "like"))"
        numberOfDislikeLabel.text = "\(countReactions(reactions: newfeedBlog.reaction, reactionType: "dislike"))"
        
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
    
    private func convertDateTimeFromMongoDBToSwift(_ dayOfBirth: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        if let date = dateFormatter.date(from: dayOfBirth) {
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
    }
    
    private func countReactions(reactions: [Reaction]?, reactionType: String) -> Int {
        guard let reactions = reactions else { return 0 }
        let count = reactions.filter { $0.reaction == reactionType }.count
        return count
    }
}
