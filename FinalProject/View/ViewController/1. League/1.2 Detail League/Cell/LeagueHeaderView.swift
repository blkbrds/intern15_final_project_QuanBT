//
//  LeagueHeaderView.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/29/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class LeagueHeaderView: UICollectionReusableView {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var badgeImageView: UIImageView!
    @IBOutlet private weak var nameLeagueLabel: UILabel!
    @IBOutlet private weak var formedYearLable: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = LeagueHeaderCellVM() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameLeagueLabel.text = dataAPI.name
        formedYearLable.text = dataAPI.year
        countryLabel.text = dataAPI.country
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
