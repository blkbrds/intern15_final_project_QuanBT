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
    
    // MARK: - Function
    private func updateView() {
        let isFavorite = viewModel.isFavorite
        if isFavorite {
            let dataFavorite = viewModel.dataAPI
            nameTeamLabel.text = dataFavorite.name
            nameStadiumLabel.text = dataFavorite.stadium
            favoriteButton.isHidden = true
            logoImageView.image = nil
            logoImageView.sd_setImage(with: URL(string: dataFavorite.badge), placeholderImage: nil)
            if logoImageView.image == nil {
                logoImageView.image = #imageLiteral(resourceName: "img-logo")
            }
        } else {
            let dataAPI = viewModel.dataAPI
            nameTeamLabel.text = dataAPI.name
            nameStadiumLabel.text = dataAPI.stadium
            logoImageView.image = nil
            logoImageView.sd_setImage(with: URL(string: dataAPI.badge), placeholderImage: nil)
            if logoImageView.image == nil {
                logoImageView.image = #imageLiteral(resourceName: "img-logo")
            }
            
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
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.isFavorite {
            let data: Team = Team()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.logo = viewModel.dataAPI.logo
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
