//
//  LeagueTableCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 4/27/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class LeagueTableCell: UITableViewCell {
    // MARK: - IBOutlet
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var nameLeagueLabel: UILabel!
    @IBOutlet private weak var formedYearLable: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel = LeagueTableCellVM() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Function
    private func updateView() {
        let favorite = viewModel.favorite
        if favorite {
            let dataFavorite = viewModel.dataFavorite
            nameLeagueLabel.text = dataFavorite.name
            formedYearLable.text = dataFavorite.year
            favoriteButton.isHidden = true
        } else {
            let dataAPI = viewModel.dataAPI
            nameLeagueLabel.text = dataAPI.name
            formedYearLable.text = dataAPI.year
            logoImageView.image = dataAPI.logoImage
            if dataAPI.favorite {
                favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            } else {
                favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    
    func configImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    // MARK: - IBAction
    @IBAction func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            viewModel.dataAPI.favorite = true
            let data: DetailLeague = DetailLeague()
            data.id = viewModel.dataAPI.id
            data.name = viewModel.dataAPI.name
            data.logo = viewModel.dataAPI.logo
            data.year = viewModel.dataAPI.year
            RealmManager.shared.addObject(with: data)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            viewModel.dataAPI.favorite = false
        }
    }
}
