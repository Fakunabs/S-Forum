//
//  HomeViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 18/10/2023.
//

import UIKit

enum HomeSectionType: CaseIterable {
    case newfeed
}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var segmentControlView: UIView!
    @IBOutlet private weak var followingView: UIView!
    @IBOutlet private weak var userStatusVIew: UIView!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var statusTextField: UITextField!
    @IBOutlet private weak var homeTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewConerRadius()
        setUpTextField()
        reloadHomeTableView()
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.navigationController?.navigationBar.isHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
}

extension HomeViewController {
    private func configTableView() {
        homeTableView.separatorStyle = .none
        homeTableView.dataSource = self
        homeTableView.delegate = self
        homeTableView.register(UINib(nibName: NewsFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.className)
    }
}

extension HomeViewController {
    private func configViewConerRadius() {
        segmentControlView.layer.cornerRadius = 10
        followingView.layer.cornerRadius = 3
        userStatusVIew.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
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
    
    private func reloadHomeTableView() {
        let refreshControl = UIRefreshControl()
            refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
            homeTableView.refreshControl = refreshControl
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch HomeSectionType.allCases[section] {
        case .newfeed:
            return 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch HomeSectionType.allCases[indexPath.section] {
        case .newfeed:
            guard let newsfeedCell = homeTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.className, for: indexPath) as? NewsFeedTableViewCell else {return UITableViewCell()}
            return newsfeedCell
        }
    }
    
    
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch HomeSectionType.allCases[indexPath.section] {
        case .newfeed:
            print("a")
        }
    }
}


extension HomeViewController {
    @objc private func refreshTableView() {
        DispatchQueue.global().async {
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
                self.homeTableView.refreshControl?.endRefreshing()
            }
        }
    }
}
