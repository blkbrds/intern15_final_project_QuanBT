//
//  TabBarViewController.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/27/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import Foundation
import UIKit

final class TabBarViewController: UITabBarController {
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        //Home
        let leagueVC = LeagueListViewController()
        let leagueNavi = UINavigationController(rootViewController: leagueVC)
        leagueNavi.navigationBar.barTintColor = App.Color.backgroundColor
        leagueVC.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic-League"), tag: 0)
        leagueVC.tabBarItem.imageInsets = UIEdgeInsets(top: tabBar.frame.height / 2 - 15, left: 0, bottom: -(tabBar.frame.height / 2 - 15), right: 0)
        
        //Search
        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchNavi.navigationBar.barTintColor = App.Color.backgroundColor
        searchVC.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic-Search"), tag: 1)
        searchVC.tabBarItem.imageInsets = UIEdgeInsets(top: tabBar.frame.height / 2 - 15, left: 0, bottom: -(tabBar.frame.height / 2 - 15), right: 0)
        
        //Favorites
        let favoritesVC = FavoriteViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesNavi.navigationBar.barTintColor = App.Color.backgroundColor
        favoritesVC.tabBarItem = UITabBarItem(title: "", image: #imageLiteral(resourceName: "ic-Heart"), tag: 2)
        favoritesVC.tabBarItem.imageInsets = UIEdgeInsets(top: tabBar.frame.height / 2 - 15, left: 0, bottom: -(tabBar.frame.height / 2 - 15), right: 0)
        
        //tabbar controller
        self.viewControllers = [leagueNavi, searchNavi, favoritesNavi]
        self.selectedIndex = 0
        self.tabBar.tintColor = App.Color.tabBarTintColor
        self.tabBar.unselectedItemTintColor = App.Color.tabBarUnselectedItemTintColor
        self.tabBar.barTintColor = App.Color.tabBarBackgroundColor
    }
}
