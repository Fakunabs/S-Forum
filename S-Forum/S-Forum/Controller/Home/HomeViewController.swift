//
//  HomeViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 18/10/2023.
//

import UIKit
import DropDown
import SDWebImage
import BetterSegmentedControl


class HomeViewController: BaseViewController {
    
    
    private let refreshControl = UIRefreshControl()
    private let homeDropDown = DropDown()
    private let actionList = ["Profile","Logout"]
    private var searchingName = [String]()
    private var searching = false
    
    var newFeedBlogList : [NewestBlog] = []
    
    @IBOutlet private weak var homeSegmentControl: UISegmentedControl!
    @IBOutlet private weak var statusView: UIView!
    @IBOutlet private weak var statusTextField: UITextField!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var newsFeedTableView: UITableView!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var dropDownButton: UIButton!
    @IBOutlet private weak var dropDownView: UIView!
    @IBOutlet private weak var homeSearchBarTextField: UITextField!
    @IBOutlet private weak var statusAvatarImage: UIImageView!
    
    
    @IBAction private func didTapedDropDownAction(_ sender: Any) {
        homeDropDown.show()
        homeDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            switch item {
            case "Profile":
                let userViewController = UserViewController()
                self.navigationController?.pushViewController(userViewController, animated: true)
            case "Logout":
                AuthenticationManager.shared.cleanCache()
                newsFeedTableView.reloadData()
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
                return titleMatch
            }.map { $0.title }
            searching = true
        } else {
            searchingName.removeAll()
            searching = false
        }
        newsFeedTableView.reloadData()
    }
    
    
    @IBAction func didTapSegmentAction(_ sender: Any) {
        newsFeedTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewConerRadius()
        configTextField(homeSearchBarTextField, placeholder: "Type here to search")
        configTextField(statusTextField, placeholder: "Let’s share what going...")
        configTableView()
        configDropDown()
        updateUserInfo()
        configCornerRadiusImage()
        getNewestBlogs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        updateUserInfo()
    }
}

extension HomeViewController {
    private func configTableView() {
        newsFeedTableView.separatorStyle = .none
        newsFeedTableView.dataSource = self
        newsFeedTableView.delegate = self
        newsFeedTableView.register(UINib(nibName: NewsFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.className)
        newsFeedTableView.register(UINib(nibName: PopularFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: PopularFeedTableViewCell.className)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        newsFeedTableView.addSubview(refreshControl)
    }
}

extension HomeViewController {
    private func configViewConerRadius() {
        statusView.layer.cornerRadius = 10
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
    
    private func configCornerRadiusImage() {
        avatarImage.circle()
        statusAvatarImage.circle()
    }
}

extension HomeViewController {
    private func configTextField(_ textField: UITextField, placeholder: String) {
        let textFields : [UITextField] = [statusTextField, homeSearchBarTextField]
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: AppFonts.fontSourceSans3Light(size: 15)!,
            .foregroundColor: AppColors.doveGray,
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch homeSegmentControl.selectedSegmentIndex {
        case 0:
            return searching ? searchingName.count : newFeedBlogList.count
        case 1:
            return 5
        default:
            break
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsfeedCell = newsFeedTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.className, for: indexPath) as? NewsFeedTableViewCell else { return UITableViewCell() }
        guard let popularfeedCell = newsFeedTableView.dequeueReusableCell(withIdentifier: PopularFeedTableViewCell.className, for: indexPath) as? PopularFeedTableViewCell else { return UITableViewCell() }
//        newsfeedCell.passDataDelegate = self
        switch homeSegmentControl.selectedSegmentIndex {
        case 0:
            var blog: NewestBlog?
            if searching {
                if indexPath.row < searchingName.count {
                    let searchResult = newFeedBlogList.filter { $0.title.localizedCaseInsensitiveContains(searchingName[indexPath.row]) }
                    blog = searchResult.first
                }
            } else {
                if indexPath.row < newFeedBlogList.count {
                    blog = newFeedBlogList[indexPath.row]
                }
            }
            
            if let blog = blog {
                newsfeedCell.setUpData(newfeedBlog: blog, searchText: searching ? homeSearchBarTextField.text : nil)
            }
        case 1:
//            let blog = newFeedBlogList[indexPath.row]
            print("a")
        default:
            break
        }
        return homeSegmentControl.selectedSegmentIndex == 0 ? newsfeedCell : popularfeedCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}


//extension HomeViewController: NewsFeedTableCellDelegate {
//    func didTapUserDetail(user: UserID) {
//        // Pass the userID to the UserViewController
//        let userViewController = UserViewController()
////        userViewController.userID = user
//        userViewController.getBlogOwnerUserInfomation()
//        self.navigationController?.pushViewController(userViewController, animated: true)
//    }
//}



extension HomeViewController {
    private func updateUserInfo() {
        guard let user = AuthenticationManager.shared.user else { return }
        avatarImage.sd_setImage(with: URL(string: user.profileImage ?? ""), placeholderImage: UIImage(named: "user-default-avatar"), options: .continueInBackground, completed: nil)
        statusAvatarImage.sd_setImage(with: URL(string: user.profileImage ?? ""), placeholderImage: UIImage(named: "user-default-avatar"), options: .continueInBackground, completed: nil)
    }
    
    private func getNewestBlogs() {
        Task {
            let result = try await Repository.getNewestBlog()
            newFeedBlogList = result
            DispatchQueue.main.async { [weak self] in
                self?.newsFeedTableView.reloadData()
            }
        }
    }
}
