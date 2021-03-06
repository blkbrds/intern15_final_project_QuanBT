//
//  TeamTableCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/6/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

protocol TeamTableCellDelegate: class {
    func addTeamTableCell(cell: TeamTableCell, didFavoriteButton data: Team)
    func deleteTeamTableCell(cell: TeamTableCell, didFavoriteButton data: [Team])
}

final class TeamTableCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var nameStadiumLabel: UILabel!
    @IBOutlet private weak var nameTeamLabel: UILabel!
    @IBOutlet private weak var highlightIndicator: UIView!
    @IBOutlet private weak var selectIndicator: UIImageView!
    
    // MARK: - Properties
    var viewModel = TeamTableCellVM() {
        didSet {
            updateView()
        }
    }
    weak var delegate: TeamTableCellDelegate?
    
    override var isSelected: Bool {
        didSet {
            highlightIndicator.isHidden = !isSelected
            selectIndicator.isHidden = !isSelected
        }
    }
    
    // MARK: - Function
    private func updateView() {
        let isFavorite = viewModel.isFavorite
        if isFavorite {
            let dataFavorite = viewModel.dataAPI
            nameTeamLabel.text = dataFavorite.name
            nameStadiumLabel.text = dataFavorite.stadium
            favoriteButton.isHidden = true
            downloadImage(imageView: logoImageView, url: dataFavorite.badge)
        } else {
            let dataAPI = viewModel.dataAPI
            nameTeamLabel.text = dataAPI.name
            nameStadiumLabel.text = dataAPI.stadium
            downloadImage(imageView: logoImageView, url: dataAPI.badge)
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
    
    private func downloadImage(imageView: UIImageView, url: String) {
        imageView.image = nil
        imageView.sd_setImage(with: URL(string: url), placeholderImage: nil)
        if imageView.image == nil {
            imageView.image = #imageLiteral(resourceName: "img-DefaultImage")
        }
    }
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.isFavorite {
            let data: Team = Team()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.badge = viewModel.dataAPI.badge
            data.stadium = viewModel.dataAPI.stadium
            favoriteButton.isSelected = true
            viewModel.dataAPI.isFavorite = true
            delegate?.addTeamTableCell(cell: self, didFavoriteButton: data)
        } else {
            favoriteButton.isSelected = false
            viewModel.dataAPI.isFavorite = false
            guard let realm = RealmManager.shared.realm else { return }
            let result = realm.objects(Team.self).filter(NSPredicate(format: "id = %@", viewModel.dataAPI.id))
            var data: [Team] = []
            data = Array(result)
            delegate?.deleteTeamTableCell(cell: self, didFavoriteButton: data)
        }
    }
}
