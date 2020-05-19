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
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var widthLayout: NSLayoutConstraint!
    
    // MARK: - Properties
    var viewModel = LeagueCollectionCellVM() {
        didSet {
            updateView()
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
        } else if index == 1 {
            setupUI()
            let dataTeam = viewModel.dataTeam
            nameLabel.text = dataTeam.name
            informationLabel.text = dataTeam.stadium
        } else {
            setupUI()
            let dataPlayer = viewModel.dataPlayer
            nameLabel.text = dataPlayer.name
            informationLabel.text = dataPlayer.date
        }
    }
    
    func configLogoImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
    
    private func setupUI() {
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth / 2 - (16)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
    }
}
