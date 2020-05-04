//
//  TeamsHeaderView.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class TeamsHeaderView: UICollectionReusableView {
    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = TeamsHeaderVM() {
        didSet {
            updateView()
        }
    }
    // MARK: - Function
    private func updateView() {
        let title = viewModel.title
        titleLabel.text = title
    }
}
