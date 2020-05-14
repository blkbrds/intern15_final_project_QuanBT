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
           FavoriteViewController(), FavoriteCollectionViewController()
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
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
