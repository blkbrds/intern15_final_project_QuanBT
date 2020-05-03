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
    
    // MARK: - Properties
    var viewModel = TeamsCollectionCellVM() {
        didSet {
            updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthLayout.constant = screenWidth / 2 - (20)
        contentViewCell.layer.cornerRadius = 10
        contentViewCell.clipsToBounds = true
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameTeamLabel.text = dataAPI.strTeam
        stadiumLabel.text = dataAPI.strStadium
    }
    
    func configbadgeImage(image: UIImage?) {
        badgeImageView.image = image ?? #imageLiteral(resourceName: "img-DefaultImage")
    }
}
