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
    }
    
    func configLogoImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    func configbadgeImage(image: UIImage?) {
        badgeImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
}
