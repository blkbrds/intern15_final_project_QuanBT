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
        let isFavorite = viewModel.isFavorite
        if isFavorite {
            let dataFavorite = viewModel.dataAPI
            nameTeamLabel.text = dataFavorite.name
            nameStadiumLabel.text = dataFavorite.stadium
            favoriteButton.isHidden = true
        } else {
            let dataAPI = viewModel.dataAPI
            nameTeamLabel.text = dataAPI.name
            nameStadiumLabel.text = dataAPI.stadium
            
            guard let realm = RealmManager.shared.realm else { return }
            if realm.objects(Team.self).filter(NSPredicate(format: "id = %@", dataAPI.id)).isEmpty {
                dataAPI.isFavorite = false
            } else {
                dataAPI.isFavorite = true
            }
            if dataAPI.isFavorite {
                favoriteButton.isSelected = true
            } else {
                favoriteButton.isSelected = false
            }
        }
    }
    
    func configLogoImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.isFavorite {
            favoriteButton.isSelected = true
            viewModel.dataAPI.isFavorite = true
            viewModel.addFavorite()
        } else {
            favoriteButton.isSelected = false
            viewModel.dataAPI.isFavorite = false
            viewModel.deleteFavorite()
        }
    }
}
