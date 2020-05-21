//
//  LeagueTableCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/27/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit
import RealmSwift

protocol LeagueTableCellDelegate: class {
    func addLeagueTableCell(cell: LeagueTableCell, didFavoriteButton data: DetailLeague)
    func deleteLeagueTableCell(cell: LeagueTableCell, didFavoriteButton data: [DetailLeague])
}

final class LeagueTableCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var nameLeagueLabel: UILabel!
    @IBOutlet private weak var formedYearLable: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var highlightIndicator: UIView!
    @IBOutlet private weak var selectIndicator: UIImageView!
    
    // MARK: - Properties
    var viewModel = LeagueTableCellVM() {
        didSet {
            updateView()
        }
    }
    weak var delegate: LeagueTableCellDelegate?
    
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
            let dataFavorite = viewModel.dataFavorite
            nameLeagueLabel.text = dataFavorite.name
            formedYearLable.text = dataFavorite.year
            favoriteButton.isHidden = true
        } else {
            let dataAPI = viewModel.dataAPI
            nameLeagueLabel.text = dataAPI.name
            formedYearLable.text = dataAPI.year
            
            guard let realm = RealmManager.shared.realm else { return }
            if realm.objects(DetailLeague.self).filter(NSPredicate(format: "id = %@", dataAPI.id)).isEmpty {
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
    
    func configImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.isFavorite {
            let data: DetailLeague = DetailLeague()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.logo = viewModel.dataAPI.logo
            data.year = viewModel.dataAPI.year
            favoriteButton.isSelected = true
            viewModel.dataAPI.isFavorite = true
            delegate?.addLeagueTableCell(cell: self, didFavoriteButton: data)
        } else {
            favoriteButton.isSelected = false
            viewModel.dataAPI.isFavorite = false
            guard let realm = RealmManager.shared.realm else { return }
            let result = realm.objects(DetailLeague.self).filter(NSPredicate(format: "id = %@", viewModel.dataAPI.id))
            var data: [DetailLeague] = []
            data = Array(result)
            delegate?.deleteLeagueTableCell(cell: self, didFavoriteButton: data)
        }
    }
}
