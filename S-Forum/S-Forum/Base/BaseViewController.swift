//
//  BaseViewController.swift
//  S-Forum
//
//  Created by Fakunabs on 30/10/2023.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createTabbar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTabbar()
    }
    
    // tạo 1 tabbar đơn giản giống như 1 tabbar bình thường
    func createTabbar() {
        let tabbar = UITabBarController()
        let homeVC = HomeViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        homeNav.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        tabbar.viewControllers = [homeNav]
        tabbar.tabBar.tintColor = .black
        tabbar.tabBar.barTintColor = .white
        tabbar.tabBar.isTranslucent = false
        tabbar.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabbar.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabbar.tabBar.layer.shadowRadius = 5
        tabbar.tabBar.layer.shadowOpacity = 0.2
        tabbar.tabBar.layer.masksToBounds = false
        tabbar.tabBar.layer.shadowPath = UIBezierPath(rect: tabbar.tabBar.bounds).cgPath
        tabbar.tabBar.layer.shouldRasterize = true
        tabbar.tabBar.layer.rasterizationScale = UIScreen.main.scale
        tabbar.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabbar.tabBar.layer.cornerRadius = 20
        tabbar.tabBar.clipsToBounds = true
        tabbar.tabBar.layer.masksToBounds = true
        tabbar.tabBar.layer.borderWidth = 0.5
        tabbar.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabbar.tabBar.layer.backgroundColor = UIColor.white.cgColor
        tabbar.tabBar.layer.shadowColor = UIColor.black.cgColor
        tabbar.tabBar.layer.shadowOffset = CGSize(width: 0, height: -1)
        tabbar.tabBar.layer.shadowRadius = 5
        tabbar.tabBar.layer.shadowOpacity = 0.2
        tabbar.tabBar.layer.masksToBounds = false
        tabbar.tabBar.layer.shadowPath = UIBezierPath(rect: tabbar.tabBar.bounds).cgPath
    }
}
