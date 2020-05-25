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
            logoImageView.image = nil
            logoImageView.sd_setImage(with: URL(string: dataLeague.logo), placeholderImage: nil)
            if logoImageView.image == nil {
                logoImageView.image = #imageLiteral(resourceName: "img-logo")
            }
        } else if index == 1 {
            setupUI()
            let dataTeam = viewModel.dataTeam
            nameLabel.text = dataTeam.name
            informationLabel.text = dataTeam.stadium
            logoImageView.image = nil
            logoImageView.sd_setImage(with: URL(string: dataTeam.badge), placeholderImage: nil)
            if logoImageView.image == nil {
                logoImageView.image = #imageLiteral(resourceName: "img-logo")
            }
        } else {
            setupUI()
            let dataPlayer = viewModel.dataPlayer
            nameLabel.text = dataPlayer.name
            informationLabel.text = dataPlayer.date
            logoImageView.image = nil
            logoImageView.sd_setImage(with: URL(string: dataPlayer.cutout), placeholderImage: nil)
            if logoImageView.image == nil {
                logoImageView.image = #imageLiteral(resourceName: "img-logo")
            }
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
