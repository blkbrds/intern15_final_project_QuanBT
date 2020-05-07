//
//  DetailTeamHeaderView.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/4/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class DetailTeamHeaderView: UICollectionReusableView {
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var jerseyImageView: UIImageView!
    @IBOutlet private weak var nameTeamLabel: UILabel!
    @IBOutlet private weak var leagueImageVIew: UIImageView!
    @IBOutlet private weak var stadiumImageView: UIImageView!
    @IBOutlet private weak var nameLeagueLabel: UILabel!
    @IBOutlet private weak var stadiumLabel: UILabel!
    @IBOutlet private weak var formedYearLable: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImageVIew.tintColor = App.Color.tabBarTintColor
        stadiumImageView.tintColor = App.Color.tabBarTintColor
    }
}
