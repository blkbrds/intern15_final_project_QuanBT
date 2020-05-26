//
//  DetailTeamHeaderView.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class DetailTeamHeaderView: UICollectionReusableView {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var badgeImageView: UIImageView!
    @IBOutlet private weak var nameTeamLabel: UILabel!
    @IBOutlet private weak var nameLeagueLabel: UILabel!
    @IBOutlet private weak var stadiumLabel: UILabel!
    @IBOutlet private weak var formedYearLable: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = DetailTeamHeaderVM() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameTeamLabel.text = dataAPI.name
        nameLeagueLabel.text = dataAPI.nameLeague
        countryLabel.text = dataAPI.country
        formedYearLable.text = dataAPI.year
        stadiumLabel.text = dataAPI.stadium
        downloadImage(imageView: logoImageView, url: dataAPI.logo, imageLiteral: #imageLiteral(resourceName: "img-logo"))
        downloadImage(imageView: badgeImageView, url: dataAPI.badge, imageLiteral: #imageLiteral(resourceName: "img-DefaultImage"))
    }
    
    private func downloadImage(imageView: UIImageView, url: String, imageLiteral: UIImage) {
        imageView.image = nil
        imageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
        if imageView.image == nil {
            imageView.image = imageLiteral
        }
    }
}
