//
//  PlayerHeaderView.swift
//  FinalProject
//
//  Created by Sếp Quân on 5/8/20.
//  Copyright © 2020 MBA0176. All rights reserved.
//
protocol PlayerHeaderDelegate: class {
    func getIdTeam(idTeam: String)
}

import UIKit

final class PlayerHeaderView: UICollectionReusableView {
    // MARK: - IBOutlet
    @IBOutlet private weak var contentViewPlayer: UIView!
    @IBOutlet private weak var cutoutImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var teamImageView: UIImageView!
    @IBOutlet private weak var nationalityImageView: UIImageView!
    @IBOutlet private weak var numberLabel: UILabel!
    @IBOutlet private weak var positionLabel: UILabel!
    @IBOutlet private weak var backgroundImageView: UIImageView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var weightLabel: UILabel!
    @IBOutlet private weak var heightLabel: UILabel!
    
    // MARK: - Properties
    var viewModel = PlayerHeaderVM() {
        didSet {
            updateView()
        }
    }
    weak var delegate: PlayerHeaderDelegate?
    
    // MARK: - Function
    private func updateView() {
        nationalityImageView.layer.cornerRadius = nationalityImageView.bounds.width / 2
        nationalityImageView.clipsToBounds = true
        let dataAPI = viewModel.dataAPI
        nationalityImageView.image = UIImage(named: "img-\(dataAPI.nationality)")
        nameLabel.text = dataAPI.name
        numberLabel.text = dataAPI.number
        positionLabel.text = dataAPI.position
        dateLabel.text = dataAPI.date
        if dataAPI.weight == "", dataAPI.height == ""{
            weightLabel.text = "70 Kg"
            heightLabel.text = "1.70 m"
        } else {
            weightLabel.text = dataAPI.weight
            heightLabel.text = dataAPI.height
        }
    }
    
    func configcutoutImage(image: UIImage?) {
        cutoutImageView.image = image ?? #imageLiteral(resourceName: "img-player")
    }
    
    func configbackgroundImage(image: UIImage?) {
        backgroundImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
        teamImageView.image = image ?? #imageLiteral(resourceName: "img-logo")
    }
    @IBAction func teamButtonTouchUpInside(_ sender: Any) {
        let dataAPI = viewModel.dataAPI
        if let delegate = delegate {
            delegate.getIdTeam(idTeam: dataAPI.idTeam)
        }
    }
}
