//
//  TeamsCollectionCell.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/1/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//

import UIKit

final class TeamsCollectionCell: UICollectionViewCell {
    // MARK: - IBOutlet
    @IBOutlet weak var nameTeamLabel: UILabel!
    @IBOutlet weak var badgeImageView: UIImageView!
    @IBOutlet weak var stadiumLabel: UILabel!
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var widthLayout: NSLayoutConstraint!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel = TeamsCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameTeamLabel.text = dataAPI.strTeam
        stadiumLabel.text = dataAPI.strStadium
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth / 2 - (16)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
        if dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    func configbadgeImage(image: UIImage?) {
        badgeImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
    
    @IBAction func favoriteButtonTouchUpInside(_ sender: Any) {
        if !viewModel.dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            viewModel.dataAPI.favorite = true
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            viewModel.dataAPI.favorite = false
        }
    }
}
