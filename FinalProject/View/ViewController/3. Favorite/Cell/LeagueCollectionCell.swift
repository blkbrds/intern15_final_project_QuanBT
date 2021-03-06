//
//  LeagueCollectionCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/11/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class LeagueCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var informationLabel: UILabel!
    @IBOutlet private weak var contentViewCell: UIView!
    @IBOutlet private weak var widthLayout: NSLayoutConstraint!
    @IBOutlet private weak var highlightIndicator: UIView!
    @IBOutlet private weak var selectIndicator: UIImageView!
    
    // MARK: - Properties
    var viewModel = LeagueCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            highlightIndicator.isHidden = !isSelected
            selectIndicator.isHidden = !isSelected
        }
    }
    
    // MARK: - Function
    private func updateView() {
        let index = viewModel.index
        if index == 0 {
            setupUI()
            let dataLeague = viewModel.dataLeague
            nameLabel.text = dataLeague.name
            informationLabel.text = dataLeague.year
            downloadImage(imageView: logoImageView, url: dataLeague.logo, imageLiteral: #imageLiteral(resourceName: "img-logo"))
        } else if index == 1 {
            setupUI()
            let dataTeam = viewModel.dataTeam
            nameLabel.text = dataTeam.name
            informationLabel.text = dataTeam.stadium
            downloadImage(imageView: logoImageView, url: dataTeam.badge, imageLiteral: #imageLiteral(resourceName: "img-DefaultImage"))
        } else {
            setupUI()
            let dataPlayer = viewModel.dataPlayer
            nameLabel.text = dataPlayer.name
            informationLabel.text = dataPlayer.date
            downloadImage(imageView: logoImageView, url: dataPlayer.cutout, imageLiteral: #imageLiteral(resourceName: "img-player"))
        }
    }
    
    private func downloadImage(imageView: UIImageView, url: String, imageLiteral: UIImage) {
        imageView.image = nil
        imageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
        if imageView.image == nil {
            imageView.image = imageLiteral
        }
    }
    
    private func setupUI() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth / 2 - (16)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
    }
}
