//
//  TabController.swift
//  S-Forum
//
//  Created by Fakunabs on 18/10/2023.
//

import UIKit

class TabController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        self.setupTabHeight()
        self.delegate = self
    }

    
    private func setupTabs() {
        UITabBar.appearance().backgroundColor = AppColors.outerSpace
        let homeViewController = self.createNav(with: AppImages.homeTabbarIcon, viewController: HomeViewController())
        let scheduleViewController = self.createNav(with: AppImages.scheduleTabbarIcon, viewController: ScheduleViewController())
        UITabBar.appearance().unselectedItemTintColor = .white
        homeViewController.tabBarItem.selectedImage = AppImages.homeSelected
        scheduleViewController.tabBarItem.selectedImage = AppImages.calendarSelected
        self.setViewControllers([homeViewController, scheduleViewController], animated: true)
        
        
    }
    
    private func setupTabHeight() {
        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: -10, left: 0, bottom: -30, right: 0)
        }
    }
    
    private func createNav(with image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.image = image
        return navigation
    }
}

extension TabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let navigationController = viewController as? UINavigationController,
           let rootViewController = navigationController.viewControllers.first,
           rootViewController is HomeViewController {
            // Đây là tab "Home," thực hiện kéo table view xuống và làm mới màn hình Home ở đây
            if let homeViewController = rootViewController as? HomeViewController {
                homeViewController.scrollToRefresh()
            }
        }
    }
}


