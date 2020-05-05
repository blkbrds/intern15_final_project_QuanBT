//
//  InformationCollectionCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class InformationCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var contentViewCell: UIView!
    @IBOutlet private weak var widthLayout: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel = InformationCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Function
    private func updateView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth - (20)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
        switch viewModel.index {
        case 0:
            titleLabel.text = "Description"
            setupTitle()
        case 1:
            titleLabel.text = "Facebook"
            setupTitle()
        case 2:
            titleLabel.text = "Youtube"
            setupTitle()
        case 3:
            titleLabel.text = "Twitter"
            setupTitle()
        default:
            titleLabel.text = "Website"
            setupTitle()
        }
    }
    
    private func setupTitle() {
        let dataAPI = viewModel.dataAPI
        if dataAPI == "" {
            textLabel.text = "---"
        } else {
            textLabel.text = dataAPI
        }
    }
}
