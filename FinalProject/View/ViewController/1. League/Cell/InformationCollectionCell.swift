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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var widthLayout: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel = InformationCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth - (20)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        switch viewModel.index {
        case 0:
            titleLabel.text = "Description"
            textLabel.text = dataAPI
        case 1:
            titleLabel.text = "Facebook"
            textLabel.text = dataAPI
        case 2:
            titleLabel.text = "Youtube"
            textLabel.text = dataAPI
        case 3:
            titleLabel.text = "Twitter"
            textLabel.text = dataAPI
        default:
            titleLabel.text = "Website"
            textLabel.text = dataAPI
        }
    }
}
