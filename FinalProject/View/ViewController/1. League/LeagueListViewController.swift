//
//  LeagueListViewController.swift
//  FinalProject
//
//  Created by MBA0176 on 4/24/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class LeagueListViewController: ViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var sportSegmentedControl: UISegmentedControl!
    @IBOutlet private var nationsButton: [UIButton]!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for item in nationsButton {
            item.layer.cornerRadius = item.bounds.width / 2
            item.clipsToBounds = true
        }
    }
    
    override func setupUI() {
        super.setupUI()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        sportSegmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        nationsButton[0].borderWidth = 4
        nationsButton[0].borderColor = App.Color.tabBarTintColor
    }
    
    private func setupButton(index: Int) {
        nationsButton.forEach { item in
            item.borderWidth = 0
        }
        nationsButton[index].borderWidth = 4
        nationsButton[index].borderColor = App.Color.tabBarTintColor
    }
    // MARK: - IBAction
    @IBAction private func nationsButtonTouchUpInside(_ sender: UIButton) {
        setupButton(index: sender.tag)
    }
}
