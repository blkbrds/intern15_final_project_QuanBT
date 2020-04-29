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
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLeagueLabel: UILabel!
    @IBOutlet weak var formedYearLable: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // MARK: - Properties
    var viewModel = LeagueTableCellVM() {
        didSet {
            updateView()
        }
    }
    
    // MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Function
    private func updateView() {
        let dataAPI = viewModel.dataAPI
        nameLeagueLabel.text = dataAPI.strLeague
        formedYearLable.text = dataAPI.intFormedYear
        if dataAPI.favorite {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.isSelected = false
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.isSelected = true
        }
    }
    
    func configImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    
    // MARK: - IBAction
    @IBAction func favoriteButtonTouchUpInside(_ sender: Any) {
        if favoriteButton.isSelected {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            favoriteButton.isSelected = false
            viewModel.dataAPI.favorite = true
        } else {
            favoriteButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
            favoriteButton.isSelected = true
            viewModel.dataAPI.favorite = false
        }
    }
}
