//
//  TeamsCollectionCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

protocol TeamsCollectionCellDelegate: class {
    func addTeamsCollectionCell(cell: TeamsCollectionCell, didFavoriteButton data: Team)
    func deleteTeamsCollectionCell(cell: TeamsCollectionCell, didFavoriteButton data: [Team])
}

final class TeamsCollectionCell: UICollectionViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet private weak var nameTeamLabel: UILabel!
    @IBOutlet private weak var badgeImageView: UIImageView!
    @IBOutlet private weak var stadiumLabel: UILabel!
    @IBOutlet private weak var contentViewCell: UIView!
    @IBOutlet private weak var widthLayout: NSLayoutConstraint!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel = TeamsCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    weak var delegate: TeamsCollectionCellDelegate?
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameTeamLabel.text = dataAPI.name
        stadiumLabel.text = dataAPI.stadium
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth / 2 - (16)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
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
    
    func configbadgeImage(image: UIImage?) {
        badgeImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
    
    @IBAction func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.isFavorite {
            let data: Team = Team()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.badge = viewModel.dataAPI.badge
            data.stadium = viewModel.dataAPI.stadium
            favoriteButton.isSelected = true
            viewModel.dataAPI.isFavorite = true
            delegate?.addTeamsCollectionCell(cell: self, didFavoriteButton: data)
        } else {
            favoriteButton.isSelected = false
            viewModel.dataAPI.isFavorite = false
            guard let realm = RealmManager.shared.realm else { return }
            let result = realm.objects(Team.self).filter(NSPredicate(format: "id = %@", viewModel.dataAPI.id))
            var data: [Team] = []
            data = Array(result)
            delegate?.deleteTeamsCollectionCell(cell: self, didFavoriteButton: data)
        }
    }
}
