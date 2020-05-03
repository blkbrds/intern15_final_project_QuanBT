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
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var nameLeagueLabel: UILabel!
    @IBOutlet weak var formedYearLable: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = LeagueHeaderCellVM() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameLeagueLabel.text = dataAPI.strLeague
        formedYearLable.text = dataAPI.intFormedYear
        countryLabel.text = dataAPI.strCountry
    }
    
    func configLogoImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    func configbadgeImage(image: UIImage?) {
        badgeImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
}
