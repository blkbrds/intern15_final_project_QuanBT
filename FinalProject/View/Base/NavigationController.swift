//
//  NavigationController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/25/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.isNotEmpty, let lastController = viewControllers.last, lastController.isMember(of: viewController.classForCoder) { return }
        super.pushViewController(viewController, animated: animated)
    }

    private func setupUI() {
        navigationBar.isTranslucent = false
        navigationBar.tintColor = App.Color.naviColor
        navigationBar.shadowImage = UIImage()
        navigationBar.setColors(background: App.Color.naviColor, text: .white)
    }

    func setUpRightButton(_ rightButton: UIButton) {
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        navigationController?.navigationItem.rightBarButtonItem = rightBarButton
    }

    func isPushFromViewController<T: UIViewController>(_ aClass: T.Type) -> Bool {
        guard viewControllers.isNotEmpty else { return false }
        let viewController = viewControllers[viewControllers.count - 2]
        return viewController.isMember(of: aClass)
    }

    func popToViewController<T: UIViewController>(_ aClass: T.Type, animated: Bool) {
        guard viewControllers.isNotEmpty else { return }
        for viewController in viewControllers {
            if viewController.isMember(of: aClass) {
                popToViewController(viewController, animated: true)
                return
            }
        }
        popViewController(animated: true)
    }
}
