//
//  HomeViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 18/10/2023.
//

import UIKit
import DropDown

class HomeViewController: UIViewController {
    
    private let refreshControl = UIRefreshControl()
    private let homeDropDown = DropDown()
    private let actionList = ["Profile","Logout"]
    private var searchingName = [String]()
    private var searching = false
    
    var newFeedBlogList : [NewFeedBlogs] = [
        NewFeedBlogs(image: AppImages.tempImage1!, title: "The 4-step SEO framework that led to a 1000% increase in traffic. Let’s talk about blogging and SEO...", author: "Thinh", firstHastag: "crypto", secondHastag: "finance", thirdHastag: "bitcoin", like: "50 like", dislike: "20 dislike", comments: "3 comments"),
        NewFeedBlogs(image: AppImages.tempImage2!, title: "OnePay - Online Payment Processing Web App - Download from uihut.com", author: "Thinh", firstHastag: "crypto", secondHastag: "finance", thirdHastag: "bitcoin", like: "50 like", dislike: "20 dislike", comments: "3 comments"),
        NewFeedBlogs(image: AppImages.tempImage3!, title: "Designing User Interfaces - how I sold 1800 copies in a few months by Michal Malewicz", author: "Thinh", firstHastag: "crypto", secondHastag: "finance", thirdHastag: "bitcoin", like: "50 like", dislike: "20 dislike", comments: "3 comments"),
    ]
    
    @IBOutlet private weak var segmentControlView: UIView!
    @IBOutlet private weak var userStatusVIew: UIView!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var statusTextField: UITextField!
    @IBOutlet private weak var newsFeedTableView: UITableView!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var dropDownButton: UIButton!
    @IBOutlet private weak var dropDownView: UIView!
    @IBOutlet private weak var homeSearchBarTextField: UITextField!
    
    @IBAction private func didTapedDropDownAction(_ sender: Any) {
        homeDropDown.show()
        homeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch item {
            case "Profile":
                let userViewController = UserViewController()
                self.navigationController?.pushViewController(userViewController, animated: true)
            case "Logout":
                self.tabBarController?.dismiss(animated: false, completion: nil)
                let loginViewController = LoginViewController()
                let navigationController = UINavigationController(rootViewController: loginViewController)
                UIApplication.shared.windows.first?.rootViewController = navigationController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
            default:
                break
            }
        }
    }
    
    @IBAction func homeSearchBarHandlerAction(_ sender: UITextField) {
        if let searchText = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines), !searchText.isEmpty {
            searchingName = newFeedBlogList.filter { blog in
                let titleMatch = blog.title.localizedCaseInsensitiveContains(searchText)
                let authorMatch = blog.author.localizedCaseInsensitiveContains(searchText)
                let hashtagMatch = blog.firstHastag.localizedCaseInsensitiveContains(searchText) ||
                blog.secondHastag.localizedCaseInsensitiveContains(searchText) ||
                blog.thirdHastag.localizedCaseInsensitiveContains(searchText)
                return titleMatch || authorMatch || hashtagMatch
            }.map { $0.title }
            searching = true
        } else {
            searchingName.removeAll()
            searching = false
        }
        newsFeedTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewConerRadius()
        configTextField(homeSearchBarTextField, placeholder: "Type here to search")
        configTextField(statusTextField, placeholder: "Let’s share what going...")
        configTableView()
        configDropDown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
    }
}

extension HomeViewController {
    private func configTableView() {
        newsFeedTableView.separatorStyle = .none
        newsFeedTableView.dataSource = self
        newsFeedTableView.delegate = self
        newsFeedTableView.register(UINib(nibName: NewsFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.className)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        newsFeedTableView.addSubview(refreshControl)
    }
}

extension HomeViewController {
    private func configViewConerRadius() {
        segmentControlView.layer.cornerRadius = 10
        userStatusVIew.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
        dropDownView.layer.cornerRadius = 10
        postButton.titleLabel?.font = AppFonts.fontSourceSans3SemiBold(size: 17)!
    }
    
    private func configDropDown() {
        homeDropDown.cornerRadius = 10
        homeDropDown.anchorView = dropDownView
        homeDropDown.dataSource = actionList
        homeDropDown.bottomOffset = CGPoint(x: 0, y: (homeDropDown.anchorView?.plainView.bounds.height)!)
        homeDropDown.topOffset = CGPoint(x: 0, y: -(homeDropDown.anchorView?.plainView.bounds.height)!)
        homeDropDown.direction = .bottom
        homeDropDown.textColor = AppColors.vermilion
        homeDropDown.textFont = AppFonts.fontGilroyMedium(size: 15)!
    }
}

extension HomeViewController {
    private func configTextField(_ textField: UITextField, placeholder: String) {
        let textFields : [UITextField] = [statusTextField, homeSearchBarTextField]
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontSourceSans3Light(size: 15)!,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholder, attributes: placeholderAttributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textFields.forEach { textField in
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: textField == homeSearchBarTextField ? 40 : 10, height: textField.frame.height))
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftView = leftView
            textField.rightView = rightView
            textField.rightViewMode = .always
            textField.leftViewMode = .always
            textField.layer.cornerRadius = 10
        }
    }
    
    @objc func refreshData() {
        refreshControl.endRefreshing()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searching ? searchingName.count : newFeedBlogList.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsfeedCell = newsFeedTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.className, for: indexPath) as? NewsFeedTableViewCell else {
            return UITableViewCell()
        }
        if searching {
            let searchResult = newFeedBlogList.filter { $0.title.localizedCaseInsensitiveContains(searchingName[indexPath.row]) }
            newsfeedCell.setUpData(newfeedBlog: searchResult.first!)
        } else {
            newsfeedCell.setUpData(newfeedBlog: newFeedBlogList[indexPath.row])
        }
        return newsfeedCell
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
