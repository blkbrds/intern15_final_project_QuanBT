//
//  TeamsCollectionCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class TeamsCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var nameTeamLabel: UILabel!
    @IBOutlet private weak var badgeImageView: UIImageView!
    @IBOutlet private weak var stadiumLabel: UILabel!
    @IBOutlet private weak var contentViewCell: UIView!
    @IBOutlet private weak var widthLayout: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel = TeamsCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Function
    private func updateView() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth / 2 - (16)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
        let dataAPI = viewModel.dataAPI
        nameTeamLabel.text = dataAPI.name
        stadiumLabel.text = dataAPI.stadium
    }
    
    func configbadgeImage(image: UIImage?) {
        badgeImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
}
