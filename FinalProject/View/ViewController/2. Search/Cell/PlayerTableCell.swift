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
        let dataAPI = viewModel.dataAPI
        namePlayerLabel.text = dataAPI.name
        ageLabel.text = dataAPI.date
        if dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func configPlayerImage(image: UIImage?) {
        playerImageView.image = image ?? #imageLiteral(resourceName: "img-player")
    }
    
    // MARK: - IBAction
    @IBAction private func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            viewModel.dataAPI.favorite = true
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            viewModel.dataAPI.favorite = false
        }
    }
}
