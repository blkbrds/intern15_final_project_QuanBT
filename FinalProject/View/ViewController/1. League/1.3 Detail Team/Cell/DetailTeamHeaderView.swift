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
        logoImageView.image = nil
        logoImageView.sd_setImage(with: URL(string: dataAPI.logo), placeholderImage: nil)
        if logoImageView.image == nil {
            logoImageView.image = #imageLiteral(resourceName: "img-logo")
        }
        
        badgeImageView.image = nil
        badgeImageView.sd_setImage(with: URL(string: dataAPI.badge), placeholderImage: nil)
        if logoImageView.image == nil {
            logoImageView.image = #imageLiteral(resourceName: "img-DefaultImage")
        }
    }
}
