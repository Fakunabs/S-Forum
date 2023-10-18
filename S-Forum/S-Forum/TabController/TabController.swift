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
    }

    
    private func setupTabs() {
        UITabBar.appearance().backgroundColor = AppColors.outerSpace
        UITabBar.appearance().unselectedItemTintColor = .white
        self.tabBar.tintColor = AppColors.vermilion
        
        let homeViewController = self.createNav(with: AppImages.homeTabbarIcon, viewController: HomeViewController())
        let scheduleViewController = self.createNav(with: AppImages.scheduleTabbarIcon, viewController: ScheduleViewController())
        let groupViewController = self.createNav(with: AppImages.groupTabbarIcon, viewController: GroupViewController())
        let podcastViewController = self.createNav(with: AppImages.podcastTabbarIcon, viewController: GroupViewController())
        let interviewViewController = self.createNav(with: AppImages.interviewTabbarIcon, viewController: GroupViewController())
        self.setViewControllers([homeViewController,scheduleViewController,groupViewController, podcastViewController,interviewViewController], animated: true)
    
    }
    
    private func setupTabHeight() {
        for item in self.tabBar.items ?? [] {
            item.imageInsets = UIEdgeInsets(top: 12, left: 0, bottom: -(12), right: 0)
        }
    }
    
    private func createNav(with image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.image = image
        return navigation
    }
}
