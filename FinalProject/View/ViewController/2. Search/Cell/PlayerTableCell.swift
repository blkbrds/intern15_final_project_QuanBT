//
//  PlayerTableCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

protocol PlayerTableCellDelegate: class {
    func addPlayerTableCell(cell: PlayerTableCell, didFavoriteButton data: Player)
    func deletePlayerTableCell(cell: PlayerTableCell, didFavoriteButton data: [Player])
}

final class PlayerTableCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var playerImageView: UIImageView!
    @IBOutlet private weak var namePlayerLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var highlightIndicator: UIView!
    @IBOutlet private weak var selectIndicator: UIImageView!
    
    // MARK: - Properties
    var viewModel = PlayerTableCellVM() {
        didSet {
            updateView()
        }
    }
    weak var delegate: PlayerTableCellDelegate?
    
    override var isHighlighted: Bool {
        didSet {
            highlightIndicator.isHidden = !isHighlighted
        }
    }
    
    override var isSelected: Bool {
        didSet {
            highlightIndicator.isHidden = !isSelected
            selectIndicator.isHidden = !isSelected
        }
    }
    
    private func updateView() {
        let isFavorite = viewModel.isFavorite
        if isFavorite {
            let dataFavorite = viewModel.dataAPI
            namePlayerLabel.text = dataFavorite.name
            ageLabel.text = dataFavorite.date
            favoriteButton.isHidden = true
            playerImageView.image = nil
            playerImageView.sd_setImage(with: URL(string: dataFavorite.cutout), placeholderImage: nil)
            if playerImageView.image == nil {
                playerImageView.image = #imageLiteral(resourceName: "img-logo")
            }
        } else {
            let dataAPI = viewModel.dataAPI
            namePlayerLabel.text = dataAPI.name
            ageLabel.text = dataAPI.date
            playerImageView.image = nil
            playerImageView.sd_setImage(with: URL(string: dataAPI.cutout), placeholderImage: nil)
            if playerImageView.image == nil {
                playerImageView.image = #imageLiteral(resourceName: "img-logo")
            }
            
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
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.isFavorite {
            let data: Player = Player()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.cutout = viewModel.dataAPI.cutout
            data.date = viewModel.dataAPI.date
            favoriteButton.isSelected = true
            viewModel.dataAPI.isFavorite = true
            delegate?.addPlayerTableCell(cell: self, didFavoriteButton: data)
        } else {
            favoriteButton.isSelected = false
            viewModel.dataAPI.isFavorite = false
            guard let realm = RealmManager.shared.realm else { return }
            let result = realm.objects(Player.self).filter(NSPredicate(format: "id = %@", viewModel.dataAPI.id))
            var data: [Player] = []
            data = Array(result)
            delegate?.deletePlayerTableCell(cell: self, didFavoriteButton: data)
        }
    }
}
