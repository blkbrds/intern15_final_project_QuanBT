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
        let homeVC = LeagueListViewController()
        let homeNavi = UINavigationController(rootViewController: homeVC)
        homeNavi.isNavigationBarHidden = true
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: " ic-home"), tag: 0)
        
        //Search
        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchNavi.isNavigationBarHidden = true
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        //Favorites
        let favoritesVC = FavoriteViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesNavi.isNavigationBarHidden = true
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        
        //tabbar controller
        self.viewControllers = [homeNavi, searchNavi, favoritesNavi]
        self.selectedIndex = 0
        self.tabBar.tintColor = App.Color.tabBarTintColor
        self.tabBar.unselectedItemTintColor = App.Color.tabBarUnselectedItemTintColor
        self.tabBar.barTintColor = #colorLiteral(red: 0.1255267065, green: 0.1703638853, blue: 0.2210178993, alpha: 1)
    }
}
