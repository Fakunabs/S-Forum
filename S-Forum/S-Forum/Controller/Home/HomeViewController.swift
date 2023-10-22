//
//  HomeViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 18/10/2023.
//

import UIKit

//enum HomeSectionType: CaseIterable {
//    case newfeed
//    case meetup
//}

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var segmentControlView: UIView!
    @IBOutlet private weak var followingView: UIView!
    @IBOutlet private weak var userStatusVIew: UIView!
    @IBOutlet private weak var postButton: UIButton!
    @IBOutlet private weak var statusTextField: UITextField!
    @IBOutlet private weak var newsFeedTableView: UITableView!
    @IBOutlet private weak var meetUpsView: UIView!
    @IBOutlet private weak var meetupsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configViewConerRadius()
        setUpTextField()
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
        meetupsTableView.separatorStyle = .none
        newsFeedTableView.separatorStyle = .none
        meetupsTableView.dataSource = self
        meetupsTableView.delegate = self
        newsFeedTableView.dataSource = self
        newsFeedTableView.delegate = self
        newsFeedTableView.register(UINib(nibName: NewsFeedTableViewCell.className, bundle: nil), forCellReuseIdentifier: NewsFeedTableViewCell.className)
        meetupsTableView.register(UINib(nibName: MeetUpsTableViewCell.className, bundle: nil), forCellReuseIdentifier: MeetUpsTableViewCell.className)
    }
}

extension HomeViewController {
    private func configViewConerRadius() {
        segmentControlView.layer.cornerRadius = 10
        followingView.layer.cornerRadius = 3
        userStatusVIew.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
        meetUpsView.layer.cornerRadius = 10
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
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == newsFeedTableView {
            return 4
        } else if tableView == meetupsTableView {
            return 4
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == newsFeedTableView {
            guard let newsfeedCell = newsFeedTableView.dequeueReusableCell(withIdentifier: NewsFeedTableViewCell.className, for: indexPath) as? NewsFeedTableViewCell else {return UITableViewCell()}
            return newsfeedCell
        } else if tableView == meetupsTableView {
            guard let meetsUpCell = meetupsTableView.dequeueReusableCell(withIdentifier: MeetUpsTableViewCell.className, for: indexPath) as? MeetUpsTableViewCell else { return UITableViewCell() }
            return meetsUpCell
        }
        return UITableViewCell()
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("a")
    }
}
