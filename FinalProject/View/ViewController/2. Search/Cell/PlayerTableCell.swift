//
//  PlayerTableCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class PlayerTableCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var namePlayerLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel = PlayerTableCellVM() {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        let isFavorite = viewModel.isFavorite
        if isFavorite {
            let dataFavorite = viewModel.dataAPI
            namePlayerLabel.text = dataFavorite.name
            ageLabel.text = dataFavorite.date
            favoriteButton.isHidden = true
        } else {
            let dataAPI = viewModel.dataAPI
            namePlayerLabel.text = dataAPI.name
            ageLabel.text = dataAPI.date
            
            guard let realm = RealmManager.shared.realm else { return }
            if realm.objects(Player.self).filter(NSPredicate(format: "id = %@", dataAPI.id)).isEmpty {
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
    
    func configPlayerImage(image: UIImage?) {
        playerImageView.image = image ?? #imageLiteral(resourceName: "img-player")
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
