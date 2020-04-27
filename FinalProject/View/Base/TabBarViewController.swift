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
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        
        //Map
        let searchVC = SearchViewController()
        let searchNavi = UINavigationController(rootViewController: searchVC)
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        searchVC.tabBarItem.badgeColor = .red
        
        //Favorites
        let favoritesVC = FavoriteViewController()
        let favoritesNavi = UINavigationController(rootViewController: favoritesVC)
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), tag: 2)
        favoritesVC.tabBarItem.badgeColor = .red
        
        //tabbar controller
        self.viewControllers = [homeNavi, searchNavi, favoritesNavi]
        self.selectedIndex = 0
        self.tabBar.tintColor = .red
        self.tabBar.unselectedItemTintColor = .blue
    }
}
