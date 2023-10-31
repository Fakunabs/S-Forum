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
    private let myDropDown = DropDown()
    private let actionList = ["Profile","Logout"]
    
    @IBOutlet private weak var segmentControlView: UIView!
    @IBOutlet private weak var followingView: UIView!
    @IBOutlet private weak var userStatusVIew: UIView!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var statusTextField: UITextField!
    @IBOutlet private weak var newsFeedTableView: UITableView!
    @IBOutlet private weak var avatarImage: UIImageView!
    @IBOutlet private weak var dropDownButton: UIButton!
    @IBOutlet private weak var dropDownView: UIView!
    
    @IBAction private func didTapedDropDownAction(_ sender: Any) {
        myDropDown.show()
        myDropDown.selectionAction = { [unowned self] (index: Int, item: String) in
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewConerRadius()
        setUpTextField()
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
        followingView.layer.cornerRadius = 3
        userStatusVIew.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
        dropDownView.layer.cornerRadius = 10
    }
    
    private func configDropDown() {
        myDropDown.cornerRadius = 10
        myDropDown.anchorView = dropDownView
        myDropDown.dataSource = actionList
        myDropDown.bottomOffset = CGPoint(x: 0, y: (myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.topOffset = CGPoint(x: 0, y: -(myDropDown.anchorView?.plainView.bounds.height)!)
        myDropDown.direction = .bottom
        myDropDown.textColor = AppColors.vermilion
        myDropDown.textFont = AppFonts.fontGilroyMedium(size: 15)!
    }
}

extension HomeViewController {
    private func setUpTextField() {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: statusTextField.frame.height))
        statusTextField.layer.cornerRadius = 10
        statusTextField.leftView = leftView
        statusTextField.rightView = rightView
        statusTextField.leftViewMode = .always
        statusTextField.rightViewMode = .always
    }
    
    @objc func refreshData() {
        refreshControl.endRefreshing()
    }
    
    func scrollToRefresh() {
        newsFeedTableView.setContentOffset(CGPoint(x: 0, y: -100), animated: true)
        refreshData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let newsfeedCell = newsFeedTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.className, for: indexPath) as? NewsFeedTableViewCell else {return UITableViewCell()}
        return newsfeedCell
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("a")
    }
}

// chỗ này là đăng xuất

// chỗ này là chức năng push qua màn hình user

