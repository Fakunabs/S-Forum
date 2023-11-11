//
//  UserViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 30/10/2023.
//

import UIKit
import DropDown

class UserViewController: BaseViewController {
    
    var newFeedBlogList : [NewFeedBlogs] = [
        NewFeedBlogs(image: AppImages.tempImage1!, title: "The 4-step SEO framework that led to a 1000% increase in traffic. Let’s talk about blogging and SEO...", author: "Thinh", firstHastag: "crypto", secondHastag: "finance", thirdHastag: "bitcoin", like: "50 like", dislike: "20 dislike", comments: "3 comments"),
        NewFeedBlogs(image: AppImages.tempImage2!, title: "OnePay - Online Payment Processing Web App - Download from uihut.com", author: "Thinh", firstHastag: "crypto", secondHastag: "finance", thirdHastag: "bitcoin", like: "50 like", dislike: "20 dislike", comments: "3 comments"),
        NewFeedBlogs(image: AppImages.tempImage3!, title: "Designing User Interfaces - how I sold 1800 copies in a few months by Michal Malewicz", author: "Thinh", firstHastag: "crypto", secondHastag: "finance", thirdHastag: "bitcoin", like: "50 like", dislike: "20 dislike", comments: "3 comments"),
    ]
    
    private let refreshControl = UIRefreshControl()
    private let userDropDown = DropDown()
    private let actionList = ["Logout"]
    
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var avatarUserImageView: UIImageView!
    @IBOutlet private weak var editProfileButton: UIButton!
    @IBOutlet private weak var dropDownView: UIView!
    @IBOutlet private weak var userScrollView: UIScrollView!
    @IBOutlet private weak var userBlogTableView: UITableView!
    
    @IBAction private func didTapReturnAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction private func didTapedDropDownAction(_ sender: Any) {
        userDropDown.show()
        userDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.tabBarController?.dismiss(animated: false, completion: nil)
            let loginViewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: loginViewController)
            UIApplication.shared.windows.first?.rootViewController = navigationController
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCornerRadius()
        configDropDown()
        reloadScrollView()
        configTableView()
    }
}

extension UserViewController {
    private func configCornerRadius() {
        coverImageView.layer.cornerRadius = 10
        containerView.layer.cornerRadius = 10
        editProfileButton.layer.cornerRadius = 5
        avatarUserImageView.layer.cornerRadius = avatarUserImageView.frame.size.width / 2
        avatarUserImageView.clipsToBounds = true
    }
    
    private func configTableView() {
        userBlogTableView.separatorStyle = .none
        userBlogTableView.dataSource = self
        userBlogTableView.delegate = self
        userBlogTableView.register(UINib(nibName: NewsFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.className)
    }
    
    
    private func configDropDown() {
        userDropDown.cornerRadius = 10
        userDropDown.anchorView = dropDownView
        userDropDown.dataSource = actionList
        userDropDown.bottomOffset = CGPoint(x: 0, y: (userDropDown.anchorView?.plainView.bounds.height)!)
        userDropDown.topOffset = CGPoint(x: 0, y: -(userDropDown.anchorView?.plainView.bounds.height)!)
        userDropDown.direction = .bottom
        userDropDown.textColor = AppColors.vermilion
        userDropDown.textFont = AppFonts.fontGilroyMedium(size: 15)!
    }
    
    private func reloadScrollView() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        userScrollView.addSubview(refreshControl)
    }
    
    @objc private func refreshData() {
        refreshControl.endRefreshing()
    }
}

extension UserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newFeedBlogList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userBlogFeed = userBlogTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.className, for: indexPath) as? NewsFeedTableViewCell else {return UITableViewCell()}
        return userBlogFeed
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("a")
    }
}
