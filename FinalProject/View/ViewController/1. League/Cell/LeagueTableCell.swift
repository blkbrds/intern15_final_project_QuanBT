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
    }
    
    func configImage(image: UIImage?) {
        logoImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
}
