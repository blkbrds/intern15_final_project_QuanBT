//
//  TeamTableCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class TeamTableCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameStadiumLabel: UILabel!
    @IBOutlet private weak var nameTeamLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = TeamTableCellVM() {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        let favorite = viewModel.isFavorite
        if favorite {
            let dataFavorite = viewModel.dataAPI
            nameTeamLabel.text = dataFavorite.name
            nameStadiumLabel.text = dataFavorite.stadium
            favoriteButton.isHidden = true
        } else {
            let dataAPI = viewModel.dataAPI
            nameTeamLabel.text = dataAPI.name
            nameStadiumLabel.text = dataAPI.stadium
            if dataAPI.favorite {
                favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    func configLogoImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            viewModel.dataAPI.favorite = true
            let data: Team = Team()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.logo = viewModel.dataAPI.logo
            data.stadium = viewModel.dataAPI.stadium
            RealmManager.shared.addObject(with: data)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            viewModel.dataAPI.favorite = false
        }
    }
}
