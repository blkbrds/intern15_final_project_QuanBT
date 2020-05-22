//
//  PageViewController.swift
//  FinalProject
//
//  Created by PCI0020 on 5/14/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PageViewController: UIPageViewController {
    lazy var subViewControllers: [UIViewController] = {
        return [
            FavoriteCollectionViewController(), FavoriteViewController()
        ]
    }()
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked))
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarButtonItems()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle,
                  navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: options)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBarButtonItems() {
        navigationController?.navigationBar.tintColor = App.Color.tabBarTintColor
        navigationItem.leftBarButtonItem = deleteBarButton
    }
    
    @objc private func didDeleteButtonClicked() {
        var message = "You want to delete all?"
        guard let realm = RealmManager.shared.realm else { return }
        let league = realm.objects(DetailLeague.self)
        var dataLeague: [DetailLeague] = []
        dataLeague = Array(league)
        let team = realm.objects(Team.self)
        var dataTeam: [Team] = []
        dataTeam = Array(team)
        let player = realm.objects(Player.self)
        var dataPlayer: [Player] = []
        dataPlayer = Array(player)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (_) in
            RealmManager.shared.deleteAllObject(with: dataTeam)
            RealmManager.shared.deleteAllObject(with: dataLeague)
            RealmManager.shared.deleteAllObject(with: dataPlayer)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
            return 
        }
        var actions: [UIAlertAction] = [cancelAction, okAction]
        if dataLeague == [] && dataTeam == [] && dataPlayer == [] {
            message = "No data"
            actions = [cancelAction]
        }
        let alert = UIAlertController(title: "Announce", message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        present(alert, animated: true, completion: nil)
    }
}

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currenIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if currenIndex <= 0 {
            return nil
        }
        return subViewControllers[currenIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currenIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if currenIndex >= subViewControllers.count - 1 {
            return nil
        }
        return subViewControllers[currenIndex + 1]
    }
}
