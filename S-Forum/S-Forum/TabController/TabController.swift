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
    }
    
    
    private func setupTabs() {
        UITabBar.appearance().backgroundColor = .white
        let homeViewController = self.createNav(with: AppImages.homeTabbarIcon, viewController: HomeViewController())
        let scheduleViewController = self.createNav(with: AppImages.scheduleTabbarIcon, viewController: ScheduleViewController())
        let groupViewController = self.createNav(with: AppImages.groupTabbarIcon, viewController: GroupViewController())
        self.setViewControllers([homeViewController,scheduleViewController,groupViewController], animated: true)
    }
    
    private func createNav(with image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigation = UINavigationController(rootViewController: viewController)
        navigation.tabBarItem.image = image
        return navigation
    }
}
